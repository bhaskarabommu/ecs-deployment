data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "nginx-deployment" {
  name = "nginx-deployment"

  tags = {
    Name = "nginx-deployment"
  }
}

resource "aws_ecs_service" "nginx-service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.nginx-deployment.id
  task_definition = aws_ecs_task_definition.nginx-task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.subnet_id]
    security_groups  = [aws_security_group.ecs-aws_security_group.id]
    assign_public_ip = "true"
  }
}

resource "aws_ecs_task_definition" "nginx-task_definition" {
  family                = "nginx-task"
  container_definitions = <<DEFINITION
[
    {
        "name": "nginx-container",
        "image": "034362058614.dkr.ecr.us-east-1.amazonaws.com/myapp:latest",
        "cpu": 256,
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ]
    }
]
DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_security_group" "ecs-aws_security_group" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-aws_security_group"
  }
}