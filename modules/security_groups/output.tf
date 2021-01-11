output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_security_group.id
}
