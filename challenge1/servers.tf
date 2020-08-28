
resource "aws_instance" "webworker1" {
  ami                    = "ami34543445"
  instance_type          = "t2.micro"
  key_name               = "eu-test"
  vpc_security_group_ids = [aws_security_group.web.id]
  subnet_id              = aws_subnet.websubnet1.id
  iam_instance_profile   = aws_iam_instance_profile.webworker.id
  associate_public_ip_address = true

  tags = {
    Name    = "webworker1"
    "env"   = "webtier"
    "stage" = "test"
  }
}

resource "aws_instance" "webworker2" {
  ami                    = "ami34543445"
  instance_type          = "t2.micro"
  key_name               = "eu-test"
  vpc_security_group_ids = [aws_security_group.web.id]
  subnet_id              = aws_subnet.websubnet2.id
  iam_instance_profile   = aws_iam_instance_profile.webworker.id
  associate_public_ip_address = true

  tags = {
    Name    = "webworker2"
    "env"   = "webtier"
    "stage" = "test"
  }
}

resource "aws_instance" "appworker1" {
  ami                    = "ami34543445"
  instance_type          = "t2.micro"
  key_name               = "eu-test"
  vpc_security_group_ids = [aws_security_group.app.id]
  subnet_id              = aws_subnet.appsubnet1.id
  iam_instance_profile   = aws_iam_instance_profile.appworker.id
  associate_public_ip_address = false

  tags = {
    Name    = "appworker1"
    "env"   = "apptier"
    "stage" = "test"
  }
}

resource "aws_instance" "appworker2" {
  ami                    = "ami34543445"
  instance_type          = "t2.micro"
  key_name               = "eu-test"
  vpc_security_group_ids = [aws_security_group.app.id]
  subnet_id              = aws_subnet.appsubnet2.id
  iam_instance_profile   = aws_iam_instance_profile.appworker.id
  associate_public_ip_address = false

  tags = {
    Name    = "appworker2"
    "env"   = "apptier"
    "stage" = "test"
  }
}
