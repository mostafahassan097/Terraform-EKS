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

variable "private_subnet_tags" {
  description = "Private subnet tags"
  type        = map(any)
}
variable "public_subnet_tags" {
  description = "Public subnet tags"
  type        = map(any)
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