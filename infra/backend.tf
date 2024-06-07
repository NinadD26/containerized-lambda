# Store terraform.tfstate in s3 bucket
terraform {
  backend "s3" {
    bucket = "all-statefile-bucket"
    key    = "lambda-container/terraform.tfstate"
    region = "us-east-1"
  }
}