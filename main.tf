data "aws_availability_zones" "available" {}
provider "aws" {
  region = var.region
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host = module.eks.endpoint
  cluster_ca_certificate =base64decode(module.eks.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.cluster.token
}


provider "helm" {
  kubernetes {
  host = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.cluster.token
  }
}


terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}


module "vpc" {
  source = "./VPC"
  env                         = var.environment
  region                      = var.region
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_cidr_blocks   = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks  = var.private_subnet_cidr_blocks
  availability_zones          = data.aws_availability_zones.available.names
  public_subnet_tags          =  {
  "kubernetes.io/role/elb" = 1
  "kubernetes.io/cluster/${var.environment}-${var.eks_name}" = "owned"
}

  private_subnet_tags         =  {
  "kubernetes.io/role/internal-elb" = 1
  "kubernetes.io/cluster/${var.environment}-${var.eks_name}" = "owned"
}

  
}


module "eks" {
  source                  = "./EKS"
  env                     = var.environment
  eks_version             = var.eks_version
  eks_name                = var.eks_name
  subnet_ids              = module.vpc.private_subnet_ids
  node_groups             = var.node_groups
  bastion_sg_id           = module.bastion.bastion_sg_id 
  vpc_id                  = module.vpc.vpc_id
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  bastion_public_ip       = module.bastion.bastion_public_ip
  bastion_role_arn        = module.bastion.role_arn
  bastion_role_name       = module.bastion.role_name
}


module "bastion" {
  source = "./Bastion"
  env               = var.environment
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.public_subnet_ids[0]
  key_name          = var.key_name
  private_key_name  = var.private_key_name
  private_key_path  = var.private_key_path
  instance_type     = var.instance_type
  ami               = var.ami 
  depends_on = [ module.eks.eks_cluster ]
  user_data = <<-EOF
  #!/bin/bash

  # Install AWS CLI v2
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  aws --version

  # Install Helm v3
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  helm version

  # Install kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  kubectl version --client

  # Install aws-iam-authenticator
  curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
  chmod +x ./aws-iam-authenticator
  mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
  echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

  #  Install eckctl for role mapping 
  ARCH=amd64
  PLATFORM=$(uname -s)_$ARCH
  curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
  tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
  sudo mv /tmp/eksctl /usr/local/bin
 
  aws sts get-caller-identity

  # Update Kubectl
  aws eks update-kubeconfig --name ${var.environment}-${var.eks_name}
EOF


}

module  "cluster_autoscaler" {
  source                         = "./Addons/cluster-autoscaler"
  env                            = var.environment
  eks_name                       = module.eks.eks_name
  cluster_autoscaler_helm_verion = "9.28.0"
  openid_provider_arn            = module.eks.openid_provider_arn
  enable_cluster_autoscaler      = true
}