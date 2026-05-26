output "lb_controller_role_arn" {
  description = "Use this ARN to annotate your service account locally"
  value       = aws_iam_role.lb_controller.arn
}

