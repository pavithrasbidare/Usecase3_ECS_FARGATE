output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "appointment_service_task_definition_arn" {
  value = aws_ecs_task_definition.appointment_service.arn
}

output "patient_service_task_definition_arn" {
  value = aws_ecs_task_definition.patient_service.arn
}

output "appointment_service_id" {
  value = aws_ecs_service.appointment_service.id
}

output "patient_service_id" {
  value = aws_ecs_service.patient_service.id
}
