region = "eu-central-1"
#====================={VPC}======================
vpc_cidr_block = "10.0.0.0/16"
environment    = "producation"
public_subnet_cidr_blocks = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24",
]

private_subnet_cidr_blocks = [
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24",
]

private_subnet_tags = {
"kubernetes.io/role/elb" = 1
"kubernetes.io/cluster/mostafa" = "owned"
}

public_subnet_tags = {
"kubernetes.io/role/elb" = 1
"kubernetes.io/cluster/mostafa" = "owned"
}

#======================={EKS}========================

eks_name = "mostafa"
eks_version = "1.27"
node_groups = {
    general = {
    capacity_type  = "ON_DEMAND"
    instance_types = ["t2.medium"]
    scaling_config = {
    desired_size  = 3
    max_size      = 5
    min_size      = 1
    }
    }
    }