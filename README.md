##  Getting Started with your Secure EKS Cluster on AWS

This repository provides Terraform modules for deploying a secure EKS cluster with a bastion host and VPC setup, ensuring controlled access and robust security.

**Key Features:**

* **VPC:**
    * 3 public subnets for internet access (services like NAT Gateway)
    * 3 private subnets for secure EKS cluster deployment
    * 1 NAT Gateway for outbound internet access
* **EKS:**
    * Secure access with OIDC authentication and IAM roles for RBAC
    * Mapped IAM role for bastion to access the cluster
    * Restrictive security group rules for cluster nodes
* **Bastion:**
    * Controlled SSH access via security group rules
    * IAM role to assume mapped EKS role for cluster access
    * Security group rules for essential services like health checks

**Requirements:**

* Terraform
* AWS CLI
* AWS credentials configured (`~/.aws/credentials` and `~/.aws/config`)

**Deployment Steps:**

1. Clone the repository.
2. Install Terraform and AWS CLI.
3. Configure your AWS credentials.
4. Update variables in `variables.tf` for each module (vpc, eks, bastion).
5. Run `terraform init` to initialize modules.
6. Preview changes with `terraform plan`.
7. Review and confirm changes.
8. Deploy the infrastructure with `terraform apply`.

**Note:** This is a basic example and can be customized for your specific needs. Consider IAM policies and Kubernetes RBAC for further access control. Back up your Terraform state regularly.

**Resources:**

* AWS VPC: [https://docs.aws.amazon.com/toolkit-for-visual-studio/latest/user-guide/vpc-tkv.html](https://docs.aws.amazon.com/toolkit-for-visual-studio/latest/user-guide/vpc-tkv.html)
* AWS EKS: [https://docs.aws.amazon.com/eks/](https://docs.aws.amazon.com/eks/)
* AWS IAM: [https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html)
* Kubernetes RBAC: [https://kubernetes.io/docs/reference/access-authn-authz/rbac/](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
