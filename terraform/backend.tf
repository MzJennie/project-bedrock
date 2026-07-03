terraform {
  backend "s3" {
    bucket         = "tfstate-karatu-student-001"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock-karatu-student-001"
  }
}
