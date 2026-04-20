terraform {
  backend "s3" {
    bucket         = "mycompany-terraform-state-dev"
    key            = "eks/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
