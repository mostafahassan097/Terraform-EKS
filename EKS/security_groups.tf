# EKS Control Plane Security Group
resource "aws_security_group" "eks_control_plane" {
  name = "eks-control-plane-sg"
  vpc_id = var.vpc_id
  ingress {
    description = "Allow bastion" 
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [var.bastion_sg_id] 
  }

  ingress {
    description = "Allow bastion public IP"
    from_port = 443
    to_port = 443 
    protocol = "tcp"
    cidr_blocks = ["${var.bastion_public_ip}/32"]
  }
} 