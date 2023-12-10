resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
    tags = {
    Name = "${var.environment}-${var.eks_cluster_name}-igw"
  }
}
