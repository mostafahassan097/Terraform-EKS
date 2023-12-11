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

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.env}-${var.eks_name}"
  version  = var.eks_version
  role_arn = aws_iam_role.master_role.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = false
    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.master_role_attach]
}