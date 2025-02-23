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
