output "bastion_public_ip" {
  description = "Public IP address of the bastion instance"
  value       = aws_instance.bastion.public_ip
}
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
output "role_name" {
  value = aws_iam_role.role.name
}
output "role_arn" {
  value = aws_iam_role.role.arn
}