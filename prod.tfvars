region = "eu-central-1"
environment    = "producation"
#====================={VPC}======================
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
#====================={Bastion}========================
key_name ="momo"
private_key_path ="."
private_key_name = "mostafa"
instance_type    = "t2.micro"
ami = "ami-0669b163befffbdfc"