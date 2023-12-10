resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id
}

resource "aws_eip" "main" {
  domain = "vpc"
}