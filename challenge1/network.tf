
resource "aws_vpc" "webtier" {
  cidr_block            = "172.31.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "webtier"
  }
}

resource "aws_vpc" "apptier" {
  cidr_block = "172.32.0.0/16"

  tags = {
    Name = "apptier"
  }
}


resource "aws_internet_gateway" "webtier" {
  vpc_id = aws_vpc.webtier.id

  tags = {
    Name = "webtier"
    "stage" = "test"
  }
}


resource "aws_subnet" "websubnet1" {
  vpc_id     = aws_vpc.webtier.id
  cidr_block = "172.31.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "websubnet1"
  }
}


resource "aws_subnet" "websubnet2" {
  vpc_id     = aws_vpc.webtier.id
  cidr_block = "172.31.2.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "websubnet2"
  }
}

resource "aws_subnet" "appsubnet1" {
  vpc_id     = aws_vpc.apptier.id
  cidr_block = "172.32.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "appsubnet1"
  }
}


resource "aws_subnet" "appsubnet2" {
  vpc_id     = aws_vpc.apptier.id
  cidr_block = "172.32.2.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "appsubnet2"
  }
}


resource "aws_route_table" "webtier" {
  vpc_id = aws_vpc.webtier.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webtier.id
  }

  route {
    cidr_block                = "172.31.0.0/16"
  }

  tags = {
    Name = "webtier"
  }
}

resource "aws_main_route_table_association" "webtier" {
  vpc_id         = aws_vpc.webtier.id
  route_table_id = aws_route_table.webtier.id
}

resource "aws_route_table" "apptier" {
  vpc_id = aws_vpc.apptier.id

  route {
    cidr_block                = "172.32.0.0/16"
  }

  tags = {
    Name = "apptier"
  }
}

resource "aws_main_route_table_association" "apptier" {
  vpc_id         = aws_vpc.apptier.id
  route_table_id = aws_route_table.apptier.id
}
