# Map IAM role to RBAC for EKS access  
resource "kubernetes_config_map" "aws-auth" {
  data = {
    "mapRoles" = <<EOT
- rolearn: ${var.bastion_role_arn}
  username:  ${var.bastion_role_name}
  groups:
    - system:bootstrappers
    - system:nodes
    - system:masters
EOT
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}
