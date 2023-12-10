#data "aws_availability_zones" "available" {}
provider "aws" {
  region = var.region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}


module "vpc" {
  source = "./VPC"
  environment                 = var.environment
  region                      = var.region
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_cidr_blocks   = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks  = var.private_subnet_cidr_blocks
  eks_cluster_name            = var.eks_cluster_name
  availability_zones          = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]  # Add your AZs here
  #availability_zones          = data.aws_availability_zones.available.names
  public_subnet_tags          = var.public_subnet_tags
  private_subnet_tags         = var.private_subnet_tags
  
}


module "eks" {
  source = "./EKS"
  environment                 = var.environment
  eks_version = var.eks_version
  eks_name    = var.eks_name
  subnet_ids  = var.subnet_ids
  node_groups = var.node_groups
  
}