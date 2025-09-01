
resource "aws_db_instance" "postgres" {
  identifier              = "java-app-postgres"
  engine                  = "postgres"
  engine_version          = "17.4"          # ✅ Just use the version number, no "-R1"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_type            = "gp2"

  db_name                 = "postgres"
  username                = "postgres"
  password                = "java-postgres" 
  port                    = 5432

  multi_az                = false
  backup_retention_period = 7
  skip_final_snapshot     = true

  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.db_subnet_group_name
  publicly_accessible     = false

  tags = {
    Name = "java-app-postgres"
  }
}
