resource "random_id" "id" {
  byte_length = 4
}

resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-actions-${random_id.id.dec}"
  display_name              = "GitHub Actions Pool"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions"
  display_name                       = "GitHub Actions Provider"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.repository"       = "assertion.repository"
  }
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    allowed_audiences = []
  }
}

resource "google_service_account" "github" {
  account_id   = "github-actions"
  display_name = "GitHub Actions Service Account"
}

resource "google_service_account_iam_binding" "github" {
  service_account_id = google_service_account.github.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository_owner/${var.github_org}"
  ]
}

# These secrets are used by the GitHub Actions workflow to authenticate with GCP via Workload Identity.
# With a GitHub free plan, we can only use organization secrets in public repositories.
resource "github_actions_organization_secret" "gcp_project_id" {
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = var.project_id
  visibility      = "all"
}

resource "github_actions_organization_secret" "gcp_workload_identity_provider" {
  secret_name     = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  plaintext_value = google_iam_workload_identity_pool_provider.github.name
  visibility      = "all"
}

resource "github_actions_organization_secret" "gcp_service_account" {
  secret_name     = "GCP_SERVICE_ACCOUNT"
  plaintext_value = google_service_account.github.email
  visibility      = "all"
}
