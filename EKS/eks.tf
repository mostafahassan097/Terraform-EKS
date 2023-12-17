resource "aws_iam_role" "master_role" {
  name = "${var.env}-${var.eks_name}-eks-master"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "master_role_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master_role.name
}

data "external" "current_ipv4" {
  program = ["bash","-c","curl ipinfo.io"]
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.env}-${var.eks_name}"
  version  = var.eks_version
  role_arn = aws_iam_role.master_role.arn

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = ["${var.bastion_public_ip}/32", "${data.external.current_ipv4.result["ip"]}/32"]
    subnet_ids = var.subnet_ids
    security_group_ids = [aws_security_group.eks_control_plane.id]
  }


  depends_on = [aws_iam_role_policy_attachment.master_role_attach]
}
