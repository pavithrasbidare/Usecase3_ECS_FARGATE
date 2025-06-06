resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.cluster_name}"
  retention_in_days = 30  # Adjust as needed
}


resource "aws_ecs_task_definition" "appointment_service" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions    = jsonencode([
    {
      name  = var.appointment_container_name
      image = var.image_url
      memory = 512
      cpu    = 256
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "appointment-service"
        }
      }
    },
    {
      name  = "xray-daemon"
      image = "amazon/aws-xray-daemon"
      essential = true
      cpu    = 50
      memory = 128
      environment = [
  {
    name  = "AWS_XRAY_TRACING_NAME"
    value = "appointment-service-trace"
  },
  {
    name  = "AWS_XRAY_DAEMON_ADDRESS"
    value = "xray.us-west-2.amazonaws.com:2000"
  },
  {
    name  = "AWS_XRAY_DAEMON_DISABLE_METADATA"
    value = "true"
  }
]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "xray"
        }
      }
    }
  ])
}



resource "aws_ecs_task_definition" "patient_service" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions    = jsonencode([
    {
      name  = var.patient_container_name
      image = var.image_url_patient
      memory = 512
      cpu    = 256
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "patient-service"
        }
      }
    },
    {
      name  = "xray-daemon"
      image = "amazon/aws-xray-daemon"
      essential = true
      cpu    = 50
      memory = 128
      environment = [
  {
    name  = "AWS_XRAY_TRACING_NAME"
    value = "appointment-service-trace"
  },
  {
    name  = "AWS_XRAY_DAEMON_ADDRESS"
    value = "xray.us-west-2.amazonaws.com:2000"
  },
  {
    name  = "AWS_XRAY_DAEMON_DISABLE_METADATA"
    value = "true"
  }
]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "xray"
        }
      }
    }
  ])
}



# ECS Service for Appointment Service
resource "aws_ecs_service" "appointment_service" {
  name            = var.appointment_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointment_service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.appointment_tg_arn
    container_name   = var.appointment_container_name
    container_port   = 3001
  }
}

# ECS Service for Patient Service
resource "aws_ecs_service" "patient_service" {
  name            = var.patient_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patient_service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    #assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.patient_tg_arn
    container_name   = var.patient_container_name
    container_port   = 3000
  }
}
