
terraform {
  backend "s3" {
    bucket         = "my-clops-backend"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}