region = "eu-central-1"
vpc_cidr_block = "10.0.0.0/16"

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

eks_cluster_name = "my-eks-cluster"
