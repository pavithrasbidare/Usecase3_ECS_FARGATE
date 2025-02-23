module "vpc" {
  source = "../Modules/VPC"
  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "alb" {
  source        = "../Modules/ALB"
  vpc_id        = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  domain_name   = var.domain_name
}

module "iam" {
  source = "../Modules/IAM"
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
  ecs_service_role_name        = var.ecs_service_role_name
}

module "ecr" {
  source    = "../Modules/ECR"
  repo_name = var.repo_name
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
  image_url                  = var.image_url
  patient_container_name     = var.patient_container_name
  image_url_patient          = var.image_url_patient
  appointment_service_name   = var.appointment_service_name
  patient_service_name       = var.patient_service_name
  subnets                    = module.vpc.public_subnets
  security_groups            = module.alb.alb_sg
  appointment_tg_arn         = module.alb.ecs_tg_arn
  patient_tg_arn             = module.alb.ecs_tg_arn
}

module "monitoring" {
  source         = "../Modules/Cloudwatch"
  log_group_name = var.log_group_name
}
