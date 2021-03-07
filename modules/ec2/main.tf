resource "aws_instance" "ec2-bastion" {
  ami                         = "ami-0be2609ba883822ec"
  instance_type               = "t3.micro"
  availability_zone           = var.availability_zones[0]
  associate_public_ip_address = true
  key_name                    = var.ssh_key_pair_name
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.public_subnet_ids[0]
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name = "EC2 Bastion"
  }
}
