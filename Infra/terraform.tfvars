# terraform.tfvars

# VPC Configuration
vpc_cidr           = "10.0.0.0/16"
vpc_name           = "my-vpc"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-west-2a", "us-west-2b"]

# ECS Configuration
region                     = "us-west-2"
cluster_name               = "my-ecs-cluster"
task_family                = "my-task-family"
ecs_task_execution_role_name = "ecsTaskExecutionRole"
ecs_service_role_name      = "ecsServiceRole"
task_cpu                   = "256"
task_memory                = "512"
appointment_container_name = "appointment-service"
image_url                  = "302263075199.dkr.ecr.us-west-2.amazonaws.com/appointment-service:latest"
patient_container_name     = "patient-service"
image_url_patient          = "302263075199.dkr.ecr.us-west-2.amazonaws.com/patient-service:latest"
appointment_service_name   = "appointment-service"
patient_service_name       = "patient-service"

# ALB Configuration
domain_name = "example.com"

# CloudWatch Configuration
log_group_name = "my-log-group"
