resource "aws_vpc" "ecs-aws_vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "ecs-aws_vpc"
  }
}

resource "aws_subnet" "ecs-aws_subnet" {
  vpc_id     = aws_vpc.ecs-aws_vpc.id
  cidr_block = "10.0.0.0/26"

  tags = {
    Name = "ecs-aws_subnet"
  }
}

resource "aws_internet_gateway" "ecs-aws_internet_gateway" {
  vpc_id = aws_vpc.ecs-aws_vpc.id

  tags = {
    Name = "ecs-aws_internet_gateway"
  }
}

resource "aws_route_table" "ecs-aws_route_table" {
  vpc_id = aws_vpc.ecs-aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-aws_internet_gateway.id
  }

  tags = {
    Name = "ecs-aws_route_table"
  }
}

resource "aws_route_table_association" "ecs-aws_route_table_association" {
  subnet_id      = aws_subnet.ecs-aws_subnet.id
  route_table_id = aws_route_table.ecs-aws_route_table.id
}
