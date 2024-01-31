variable "project_id" {
  description = "Project ID where the resources will be created"
  type        = string
}

variable "region" {
  description = "Region where the resources are going to be created"
  type        = string
  default     = "europe-west1"
}

variable "pods_range_name" {
  description = "Name of the secondary subnet ip range to use for pods in GKE cluster"
  type        = string
  default     = "pods-range"
}

variable "pods_range_ip_cidr_range" {
  description = "CIDR range of the secondary subnet ip range to use for pods in GKE cluster"
  type        = string
  default     = "192.168.0.0/18"
}

variable "services_range_name" {
  description = "Name of the secondary subnet ip range to use for services in GKE cluster"
  type        = string
  default     = "services-range"
}

variable "services_range_ip_cidr_range" {
  description = "CIDR range of the secondary subnet ip range to use for services in GKE cluster"
  type        = string
  default     = "192.168.64.0/18"
}

variable "cluster_name" {
  description = "Name of the GKE to be created"
  type        = string
  default     = "idp"
}

variable "cluster_subnet_name" {
  description = "Name of the subnet where the GKE cluster will be created"
  type        = string
  default     = "subnet-01"
}

variable "cluster_version" {
  description = "The Kubernetes version of the masters for the GKE cluster. If set to 'latest' it will pull latest available version in the selected region."
  type        = string
  default     = "1.27"
}

variable "github_org" {
  description = "Github organization to authenticate against"
  type        = string
}

variable "email" {
  description = "Email to use for the certificate"
  type        = string
  sensitive   = true
}
