# Creates RDS Instance 
resource "aws_db_instance" "mysql" {
  identifier           = "robo-${var.ENV}-mysql"
  allocated_storage    = var.RDS_STORAGE
  #db_name              = "mydb" #The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines.
  engine               = "mysql"
  engine_version       = var.RDS_ENGINE_VERSION
  instance_class       = var.RDS_INSTANCE_CLASS
  username             = local.RDS_USER
  password             = local.RDS_PASSWD
  parameter_group_name = aws_db_parameter_group.mysql_pg.name
  skip_final_snapshot  = true # This will ensure it won't take snapshot when you destroy
  db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.allow-mysql.id] 
}

#creates parameter_group
resource "aws_db_parameter_group" "mysql_pg" {
  name   = "robo-${var.ENV}-mysql-pg"
  family = "mysql${var.RDS_ENGINE_VERSION}"
}

#creates the subnet_group
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "robo-${var.ENV}-mysql-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID

  tags = {
    Name = "robo-${var.ENV}-mysql-subet-group"
  }
}



