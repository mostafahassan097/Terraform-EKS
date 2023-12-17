output "eks_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "openid_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc[0].arn
}
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}
output "certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}
