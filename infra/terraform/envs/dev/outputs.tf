output "cluster_name" { value = aws_eks_cluster.this.name }
output "cluster_region" { value = var.aws_region }
output "ecr_repo_url" { value = aws_ecr_repository.app.repository_url }
output "gha_role_arn" { value = aws_iam_role.github_actions.arn }
