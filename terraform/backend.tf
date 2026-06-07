terraform {
  backend "s3" {
    bucket         = "project-bedrock-tfstate-3635"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}
