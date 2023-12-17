variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

#==================={VPC Module}========================

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

#=============================={EKS Module}============================

variable "eks_version" {
  description = "Desired Kubernetes master version."
  type        = string
}

variable "eks_name" {
  description = "Name of the cluster."
  type        = string
}
variable "endpoint_private_access" {
  type = bool
  default = true
}
variable "endpoint_public_access" {
  type = bool
  default = true
}

variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes."
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

variable "node_groups" {
  description = "EKS node groups"
  type        = map(any)
}

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

#============================{Bastion}============================================
variable "ami" {
  description = "AMI ID"
  type = string
  default = "ami-0c55b159cbfafe1f0"
}
variable "instance_type" {
  description = "instance type"
  type = string
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