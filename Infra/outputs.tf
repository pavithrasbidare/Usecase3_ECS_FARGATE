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
