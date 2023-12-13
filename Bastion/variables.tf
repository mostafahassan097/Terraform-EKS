variable "env" {
  description = "Environment name."
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair for the Bastion host"
  type        = string
}
variable "private_key_path" {
  description = "Path to the private key file for SSH access"
  type        = string
}
variable "private_key_name" {
  description = "Name of the private key file for SSH access"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the bastion instance will be launched"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type = string
  default = "ami-0c55b159cbfafe1f0"
}
variable "instance_type" {
  description = "instance type"
  type = string
}


variable "user_data" {
  description = "User data script for the bastion instance"
  type        = string
}
