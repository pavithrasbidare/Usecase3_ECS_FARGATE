output "dns_name" {
  value = aws_lb.ecs_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}

output "alb_sg" {
  description = "Security group for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "ecs_tg_arn" {
  description = "Target group ARN for ECS"
  value       = aws_lb_target_group.this.arn
}
