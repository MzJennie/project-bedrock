output "mysql_endpoint" {
  value = aws_db_instance.mysql.address
}

output "mysql_port" {
  value = aws_db_instance.mysql.port
}

output "postgres_endpoint" {
  value = aws_db_instance.postgres.address
}

output "postgres_port" {
  value = aws_db_instance.postgres.port
}

output "mysql_secret_arn" {
  value = aws_secretsmanager_secret.mysql_credentials.arn
}

output "postgres_secret_arn" {
  value = aws_secretsmanager_secret.postgres_credentials.arn
}
