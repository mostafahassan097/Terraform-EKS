#data "aws_availability_zones" "available" {}
module "eks_vpc" {
  source = "./Network"
  region                      = var.region
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_cidr_blocks   = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks  = var.private_subnet_cidr_blocks
  eks_cluster_name            = var.eks_cluster_name
    availability_zones          = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]  # Add your AZs here
  #availability_zones          = data.aws_availability_zones.available.names
}