module "vpc" {
  source            = "../Modules/VPC"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  availability_zones = var.availability_zones
}

module "iam" {
  source = "../Modules/IAM"
  ecs_service_role_name        = var.ecs_service_role_name
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
}

module "ecr" {
  source = "../Modules/ECR"
}

module "ecs" {
  source = "../Modules/ECS"
  region                     = var.region
  cluster_name               = var.cluster_name
  task_family                = var.task_family
  execution_role             = module.iam.ecs_task_execution_role_arn
  task_cpu                   = var.task_cpu
  task_memory                = var.task_memory
  appointment_container_name = var.appointment_container_name
  image_url                  = module.ecr.appointment_service_repository_url
  patient_container_name     = var.patient_container_name
  image_url_patient          = module.ecr.patient_service_repository_url
  appointment_service_name   = var.appointment_service_name
  patient_service_name       = var.patient_service_name
  subnets                    = module.vpc.public_subnets
  security_groups            = module.alb.alb_sg
  appointment_tg_arn         = module.alb.ecs_tg_arn
  patient_tg_arn             = module.alb.ecs_tg_arn
}

module "alb" {
  source      = "../Modules/ALB"
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.public_subnets
  domain_name = var.domain_name
}

module "monitoring" {
  source         = "../Modules/Cloudwatch"
  log_group_name = var.log_group_name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.iam.ecs_task_execution_role_arn
}

output "ecs_service_role_arn" {
  description = "ARN of the ECS service role"
  value       = module.iam.ecs_service_role_arn
}

output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value       = module.ecs.ecs_cluster_id
}

output "ecs_service_appointment" {
  description = "ECS service name for appointment service"
  value       = module.ecs.ecs_service_appointment
}

output "ecs_service_patient" {
  description = "ECS service name for patient service"
  value       = module.ecs.ecs_service_patient
}
