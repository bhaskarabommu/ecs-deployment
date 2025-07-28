output "vpc_id" {
  value = aws_vpc.ecs-aws_vpc.id
}

output "subnet_id" {
  value = aws_subnet.ecs-aws_subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.ecs-aws_internet_gateway.id
}