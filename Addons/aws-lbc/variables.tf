variable "env" {
  description = "Environment name."
  type        = string
}

variable "eks_name" {
  description = "Name of the cluster."
  type        = string
}


variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "aws_region" {
  description = "aws_region"
  type        = string
}
variable "cluster_id" {
  description = "cluster_id"
  type        = string
}

variable "openid_provider_arn" {
  description = "IAM Openid Connect Provider ARN"
  type        = string
}