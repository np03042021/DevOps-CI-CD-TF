terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket-cicdfinal"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
