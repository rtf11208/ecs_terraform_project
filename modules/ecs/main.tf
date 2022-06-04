resource "aws_ecr_repository" "ecs_demo" {
  name                 = "ecs_terraform_project"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_task_definition" "worker" {
  family                = "worker"
  container_definitions = file("../../modules/ecs/ecs_task_definition.json")
}

resource "aws_ecs_cluster" "ecs_cluster" {
    name = "my_cluster"
  }

resource "aws_ecs_service" "ecs_services" {
  name            = "ronnies_ecs_project"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.worker.arn
  desired_count   = 2

  load_balancer {
    container_name    = "worker"
    container_port    = 80
    target_group_arn  = var.target_group_arn
  }
}