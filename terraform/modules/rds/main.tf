resource "aws_db_subnet_group" "mysql" {
  name       = "${var.project_name}-mysql-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-mysql-subnet-group"
  })
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${var.project_name}-postgres-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-postgres-subnet-group"
  })
}

resource "aws_db_instance" "mysql" {
  identifier        = "${var.project_name}-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "retailstore"
  username = "bedrockadmin"
  password = var.db_password_mysql

  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [var.rds_mysql_sg_id]

  skip_final_snapshot     = true
  backup_retention_period = 0
  multi_az                = false
  publicly_accessible     = false

  tags = merge(var.tags, {
    Name = "${var.project_name}-mysql"
  })
}

resource "aws_db_instance" "postgres" {
  identifier        = "${var.project_name}-postgres"
  engine            = "postgres"
  engine_version    = "15.8"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "retailstore"
  username = "bedrockadmin"
  password = var.db_password_postgres

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [var.rds_postgres_sg_id]

  skip_final_snapshot     = true
  backup_retention_period = 0
  multi_az                = false
  publicly_accessible     = false

  tags = merge(var.tags, {
    Name = "${var.project_name}-postgres"
  })
}

resource "aws_secretsmanager_secret" "mysql_credentials" {
  name = "${var.project_name}-mysql-credentials"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "mysql_credentials" {
  secret_id = aws_secretsmanager_secret.mysql_credentials.id
  secret_string = jsonencode({
    username = "bedrockadmin"
    password = var.db_password_mysql
    host     = aws_db_instance.mysql.address
    port     = 3306
    dbname   = "retailstore"
  })
}

resource "aws_secretsmanager_secret" "postgres_credentials" {
  name = "${var.project_name}-postgres-credentials"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "postgres_credentials" {
  secret_id = aws_secretsmanager_secret.postgres_credentials.id
  secret_string = jsonencode({
    username = "bedrockadmin"
    password = var.db_password_postgres
    host     = aws_db_instance.postgres.address
    port     = 5432
    dbname   = "retailstore"
  })
}
