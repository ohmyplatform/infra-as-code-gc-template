output "gke_ca_certificate" {
  sensitive = true
  value     = module.gke.ca_certificate
}

output "gke_endpoint" {
  value     = module.gke.endpoint
  sensitive = true
}

output "github_service_account_email" {
  value = google_service_account.github.email
}

output "github_actions_identity_pool_provider_name" {
  value = google_iam_workload_identity_pool_provider.github.name
}
