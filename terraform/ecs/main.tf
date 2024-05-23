resource "aws_ecs_cluster" "nodeapp_cluster" {
  name = "nodeapp-cluster"
}

resource "aws_ecs_task_definition" "nodeapp_task" {
  family                   = "nodeapp-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::850286438394:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::850286438394:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "nodeapp"
      image     = "850286438394.dkr.ecr.eu-central-1.amazonaws.com/nodeapp:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "nodeapp_service" {
  name            = "nodeapp-service"
  cluster         = aws_ecs_cluster.nodeapp_cluster.id
  task_definition = aws_ecs_task_definition.nodeapp_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups    = [var.security_group_id]
    subnets            = ["subnet-062c580ab0771b9e8", "subnet-01262f7482a68dc41"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn
    container_name   = "nodeapp"
    container_port   = 3000
  }
}
