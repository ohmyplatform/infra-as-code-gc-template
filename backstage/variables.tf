variable "project_id" {
  description = "Project ID where the resources will be created"
  type        = string
}

variable "base_domain" {
  description = "Base domain to access the cluster"
  type        = string
}

variable "github_org" {
  description = "Github organization to authenticate against"
  type        = string
}

variable "backstage_techdocs_bucket_name" {
  description = "Techdocs bucket name"
  type        = string
}

variable "backstage_auth_github_client_id" {
  description = "Github client ID for authentication"
  type        = string
  sensitive   = true
}

variable "backstage_auth_github_client_secret" {
  description = "Github client secret for authentication"
  type        = string
  sensitive   = true
}

variable "backstage_integration_github_app_id" {
  description = "Github app ID for integration"
  type        = string
  sensitive   = true
}

variable "backstage_integration_github_client_id" {
  description = "Github client ID for integration"
  type        = string
  sensitive   = true
}

variable "backstage_integration_github_client_secret" {
  description = "Github client secret for integration"
  type        = string
  sensitive   = true
}

variable "backstage_integration_github_private_key" {
  description = "Github private key for integration"
  type        = string
  sensitive   = true
}
