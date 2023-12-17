variable "env" {
  description = "Environment name."
  type        = string
}

variable "eks_version" {
  description = "Desired Kubernetes master version."
  type        = string
}

variable "eks_name" {
  description = "Name of the cluster."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs. Must be in at least two different availability zones."
  type        = list(string)
}

variable "bastion_sg_id" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "bastion_public_ip" {
  description = "bastion ip"
  type        = string
}

variable "bastion_role_name" {
  description = "bastion_role_name"
  type        = string
}

variable "bastion_role_arn" {
  description = "bastion_role_arn"
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