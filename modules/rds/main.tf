data "aws_ssm_parameter" "database_name" {
  name = "/rds-learning/database-name"
}

data "aws_ssm_parameter" "database_username" {
  name            = "/rds-learning/database-username"
  with_decryption = true
}

data "aws_ssm_parameter" "database_password" {
  name            = "/rds-learning/database-password"
  with_decryption = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "aurora-cluster-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_rds_cluster_parameter_group" "cluster_param_group" {
  name   = "cluster-param-group"
  family = "aurora5.6"
}

resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier              = "aurora-cluster"
  engine_version                  = "5.6.mysql_aurora.1.23.0"
  availability_zones              = var.availability_zones
  database_name                   = data.aws_ssm_parameter.database_name.value
  master_username                 = data.aws_ssm_parameter.database_username.value
  master_password                 = data.aws_ssm_parameter.database_password.value
  backup_retention_period         = 5
  preferred_backup_window         = "07:00-09:00"
  vpc_security_group_ids          = [var.db_security_group_id]
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_param_group.name
  final_snapshot_identifier       = "testdb-final-snapshot"
  skip_final_snapshot             = true
  deletion_protection             = false
}

resource "aws_db_parameter_group" "cluster_instance_param_group" {
  name   = "cluster-instance-param-group"
  family = "aurora5.6"
}

resource "aws_rds_cluster_instance" "cluster_instance" {
  count                        = var.instances_count
  cluster_identifier           = aws_rds_cluster.db_cluster.id
  identifier                   = "db-${count.index}"
  instance_class               = "db.r5.large"
  engine                       = aws_rds_cluster.db_cluster.engine
  engine_version               = aws_rds_cluster.db_cluster.engine_version
  apply_immediately            = true
  publicly_accessible          = false
  performance_insights_enabled = true
  db_subnet_group_name         = aws_db_subnet_group.db_subnet_group.name
  db_parameter_group_name      = aws_db_parameter_group.cluster_instance_param_group.name
}



