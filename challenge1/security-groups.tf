resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow standard http and https ports inbound and everything outbound"
  vpc_id      = aws_vpc.webtier.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "webtier"
    "env"     = "webtier"
    "stage"   = "test"
    "purpose" = "web"
  }

}

resource "aws_security_group" "app" {
  name        = "web"
  description = "Allow standard http and https ports inbound and everything outbound"
  vpc_id      = aws_vpc.apptier.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "apptier"
    "env"     = "apptier"
    "stage"   = "test"
    "purpose" = "app"
  }

}

resource "aws_security_group" "db" {
  name        = "db"
  description = "Allow standard http and https ports inbound plus 3306 to web sg"
  vpc_id      = aws_vpc.apptier.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks      = [aws_vpc.webtier.cidr_block]
    description     = "cluster VPC"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "dbtier"
    "env"     = "dbtier"
    "stage"   = "test"
    "purpose" = "DB"
  }

}
