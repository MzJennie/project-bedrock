variable "project_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "rds_mysql_sg_id" {
  type = string
}

variable "rds_postgres_sg_id" {
  type = string
}

variable "db_password_mysql" {
  type      = string
  sensitive = true
}

variable "db_password_postgres" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
