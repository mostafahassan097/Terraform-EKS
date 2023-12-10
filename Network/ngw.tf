resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id
  
    tags = {
    Name = "${var.eks_cluster_name}-ngw"
  }
  depends_on = [aws_internet_gateway.igw]
  
}

resource "aws_eip" "eip" {
  domain = "vpc"  
    tags = {
    Name = "${var.eks_cluster_name}-eip"
  }
}