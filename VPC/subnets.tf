resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  cidr_block = var.public_subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = merge (
    {Name = "${var.environment}-public-${var.availability_zones[count.index]}"},
    var.public_subnet_tags
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  cidr_block = var.private_subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.main.id
  availability_zone =element(var.availability_zones, count.index)

  tags = merge (
    {Name = "${var.environment}-private-${var.availability_zones[count.index]}"},
    var.private_subnet_tags
  )
}
