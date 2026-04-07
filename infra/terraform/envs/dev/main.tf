provider "aws" {
  region = var.aws_region
}

# 1) ECR repository
resource "aws_ecr_repository" "app" {
  name = var.ecr_repo_name
}

# 2) EKS Cluster (simplified; in production use modules and proper VPC)
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}
