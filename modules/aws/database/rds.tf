resource "aws_db_instance" "rds-database" {
 // depends_on = [aws_db_instance.rds-database] 
  instance_class = var.instance_class
  allocated_storage = 20
  engine = var.db_engine
  engine_version = var.engine_version
  name = var.db_name
  username = var.db_username
  password = var.db_password
  parameter_group_name = var.db_parameter
  db_subnet_group_name = aws_db_subnet_group.rdssubnet.id
  vpc_security_group_ids = [aws_security_group.bancosg.id]
}

resource "aws_db_subnet_group" "rdssubnet" {
  name = var.name_sub_rds
  subnet_ids = [var.sub_database_id, var.sub_database2_id]
}
resource "aws_security_group" "bancosg" {
  name = "bancosg"
  vpc_id = var.vpc_id
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
}

