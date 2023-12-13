output "bastion_public_ip" {
  description = "Public IP address of the bastion instance"
  value       = aws_instance.bastion.public_ip
}
