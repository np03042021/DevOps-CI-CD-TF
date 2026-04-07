terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket-cicd"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-tf-lock"
    encrypt        = true
  }
}
