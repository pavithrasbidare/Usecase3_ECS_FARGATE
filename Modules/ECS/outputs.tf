output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.main.id
}

output "ecs_service_appointment" {
  description = "ECS service name for appointment service"
  value       = aws_ecs_service.appointment_service.name
}

output "ecs_service_patient" {
  description = "ECS service name for patient service"
  value       = aws_ecs_service.patient_service.name
}
