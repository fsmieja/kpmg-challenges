resource "aws_db_instance" "dbtier" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  name                        = "kpmg"
  username                    = "kpmg"
  password                    = "kpmg"
  parameter_group_name        = "default.mysql5.7"
  publicly_accessible         = true     # so we can access from my PC
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true

  vpc_security_group_ids = [aws_security_group.db.id]

  tags = {
    Name  = "dbtier"
    Stage = "test"
    Env   = "dbtier"
  }
}
