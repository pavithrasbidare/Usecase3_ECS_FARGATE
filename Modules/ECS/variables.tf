variable "region" {
  description = "AWS region"
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

variable "execution_role" {
  description = "IAM role for ECS task execution"
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

variable "subnets" {
  description = "Subnets for the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups for the ECS service"
  type        = list(string)
}

variable "appointment_tg_arn" {
  description = "Target group ARN for appointment service"
  type        = string
}

variable "patient_tg_arn" {
  description = "Target group ARN for patient service"
  type        = string
}
