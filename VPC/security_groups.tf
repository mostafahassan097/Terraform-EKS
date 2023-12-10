# resource "aws_security_group" "eks_cluster" {
#   vpc_id = aws_vpc.main.id

#   // Ingress rules
#   ingress {
#     from_port = 0
#     to_port   = 65535
#     protocol  = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   // Egress rules
#   egress {
#     from_port = 0
#     to_port   = 0
#     protocol  = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

  