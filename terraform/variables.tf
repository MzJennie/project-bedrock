variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "project-bedrock"
}

variable "student_id" {
  description = "Student ID suffix"
  type        = string
  default     = "alt-soe-025-3635"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_password_mysql" {
  description = "MySQL RDS password"
  type        = string
  sensitive   = true
}

variable "db_password_postgres" {
  description = "PostgreSQL RDS password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Project     = "karatu-2025-capstone"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
