variable "project_name" {
  type = string
}

variable "student_id" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
