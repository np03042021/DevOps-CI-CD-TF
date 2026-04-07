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
  role_arn = arn:aws:iam::755663465576:role/GitHubActionsEKSDeployRole
}

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
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}
data "aws_iam_policy_document" "gha_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:np03042021/DevOps-CI-CD-TF:ref:refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name               = "GitHubActionsEKSDeployRole"
  assume_role_policy = data.aws_iam_policy_document.gha_assume_role.json
}
resource "aws_iam_role_policy" "gha_eks_describe" {
  name = "gha-eks-describe"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["eks:DescribeCluster"],
      Resource = aws_eks_cluster.this.arn
    }]
  })
}
