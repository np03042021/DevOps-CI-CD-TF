terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "my-tf-lock"
    encrypt        = true
  }
}
