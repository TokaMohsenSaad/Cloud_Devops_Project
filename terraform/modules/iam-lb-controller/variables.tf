variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL from the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider"
  type        = string
}
