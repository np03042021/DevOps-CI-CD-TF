variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "ecr_repo_name" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "spring-eks-demo"
}
variable "cluster_name" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "demo-eks"
}
