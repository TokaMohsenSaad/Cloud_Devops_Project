variable "vpc_id" {
  description = "The ID of the VPC where the Jenkins server will be deployed"
  type        = string
  
}

variable "public_subnet_id" {
  description = "The ID of the public subnet for the Jenkins EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the Jenkins EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of ssh key pair"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access (restrict to your IP)"
  type        = string
  default     = "10.0.0.0/16" 
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 20
}

variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
  default     = "clouddevops"
}