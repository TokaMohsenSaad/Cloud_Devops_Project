output "jenkins_public_ip" {
  description = "Public IP address of the Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_private_ip" {
  description = "Private IP address of the Jenkins server"
  value       = aws_instance.jenkins.private_ip
}

output "jenkins_instance_id" {
  description = "EC2 instance ID of the Jenkins server"
  value       = aws_instance.jenkins.id
}

output "jenkins_security_group_id" {
  description = "Security group ID attached to Jenkins"
  value       = aws_security_group.jenkins.id
}