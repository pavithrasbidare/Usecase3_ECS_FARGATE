variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  type        = string
}

variable "ecs_service_role_name" {
  description = "Name of the ECS service role"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "task_family" {
  description = "ECS task family"
  type        = string
}

variable "task_cpu" {
  description = "Task CPU units"
  type        = string
}

variable "task_memory" {
  description = "Task memory in MiB"
  type        = string
}

variable "appointment_container_name" {
  description = "Container name for appointment service"
  type        = string
}

variable "image_url" {
  description = "Docker image URL for appointment service"
  type        = string
}

variable "patient_container_name" {
  description = "Container name for patient service"
  type        = string
}

variable "image_url_patient" {
  description = "Docker image URL for patient service"
  type        = string
}

variable "appointment_service_name" {
  description = "ECS service name for appointment service"
  type        = string
}

variable "patient_service_name" {
  description = "ECS service name for patient service"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch Log Group Name"
  type        = string
  default     = "ecs-logs"
}
