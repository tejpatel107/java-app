resource "aws_db_subnet_group" "subnet_group" {
  name       = "java-app-rds-subnet-group"
  subnet_ids = [
    module.private_subnet_1.subnet_id,
    module.private_subnet_2.subnet_id,
    module.private_subnet_3.subnet_id
  ]

  tags = {
    Name = "java-app-rds-subnet-group"
  }
}

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

  vpc_security_group_ids  = [module.rds_security_group.sg_id]
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  publicly_accessible     = false

  tags = {
    Name = "java-app-postgres"
  }
}
