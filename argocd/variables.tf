variable "base_domain" {
  description = "Base domain to access the cluster"
  type        = string
}

variable "argocd_apps_repository_url" {
  description = "Repository URL that ArgoCD will access to deploy apps"
  type        = string
}

variable "argocd_sso_client_id" {
  description = "ArgoCD SSO Client ID"
  type        = string
}

variable "argocd_sso_client_secret" {
  description = "ArgoCD SSO Client Secret"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "Github organization to authenticate against"
  type        = string
}
