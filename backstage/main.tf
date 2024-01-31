/*
We are creating a bucket for storing the techdocs files.
We create a service account for backstage and give it the role of storage admin.
We create a key for the service account and store it in a secret.

NOTE: The best way is to use federated identity.
      We will change this in the future.
*/
locals {
  backstage_secrets = templatefile("${path.module}/k8s/backstage-secrets.yaml.tpl", {
    auth_github_client_id             = base64encode(var.backstage_auth_github_client_id)
    auth_github_client_secret         = base64encode(var.backstage_auth_github_client_secret)
    integration_github_app_id         = base64encode(var.backstage_integration_github_app_id)
    integration_github_client_id      = base64encode(var.backstage_integration_github_client_id)
    integration_github_client_secret  = base64encode(var.backstage_integration_github_client_secret)
    integration_github_private_key    = base64encode(var.backstage_integration_github_private_key)
    integration_github_webhook_secret = base64encode("required_but_not_used")
    postgres_admin_password           = base64encode(random_password.backstage_postgres_admin_password.result)
    postgres_user_password            = base64encode(random_password.backstage_postgres_user_password.result)

    # service account key is base64 encoded
    google_application_credentials = google_service_account_key.backstage.private_key
  })
  backstage_namespace = templatefile("${path.module}/k8s/backstage-namespace.yaml.tpl", {})
}

resource "random_password" "backstage_postgres_admin_password" {
  length  = 18
  special = false
}

resource "random_password" "backstage_postgres_user_password" {
  length  = 18
  special = false
}

resource "google_storage_bucket" "backstage_techdocs" {
  project       = var.project_id
  name          = var.backstage_techdocs_bucket_name
  storage_class = "STANDARD"
  location      = "EUROPE-WEST1"

  public_access_prevention = "enforced"
}

resource "google_service_account" "backstage" {
  account_id   = "backstage"
  display_name = "Backstage Service Account"
}

resource "google_storage_bucket_iam_binding" "backstage_techdocs" {
  bucket = google_storage_bucket.backstage_techdocs.name
  role   = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.backstage.email}",
    "serviceAccount:${data.terraform_remote_state.gke.outputs.github_service_account_email}",
  ]
}

resource "google_service_account_key" "backstage" {
  service_account_id = google_service_account.backstage.id
}

# ------------------
# Kubernetes secrets
# ------------------
# We create the namespace and secrets for Backstage.
# We will use Secrets Manager in the future.
resource "kubectl_manifest" "backstage_namespace" {
  yaml_body = local.backstage_namespace
}

resource "kubectl_manifest" "backstage_secrets" {
  yaml_body = local.backstage_secrets
  depends_on = [
    kubectl_manifest.backstage_namespace
  ]
}

# ------------------
# Repository secrets
# ------------------
# These secrets are used by the GitHub Actions workflow to authenticate with GCP via Workload Identity.
# The secrets are stored in the GitHub repository because we can't use organization secrets
# in private repositories without a paid plan.
resource "github_actions_secret" "gcp_project_id" {
  repository      = "backstage"
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = var.project_id
}

resource "github_actions_secret" "gcp_workload_identity_provider" {
  repository      = "backstage"
  secret_name     = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  plaintext_value = data.terraform_remote_state.gke.outputs.github_actions_identity_pool_provider_name
}

resource "github_actions_secret" "gcp_service_account" {
  repository      = "backstage"
  secret_name     = "GCP_SERVICE_ACCOUNT"
  plaintext_value = data.terraform_remote_state.gke.outputs.github_service_account_email
}

resource "tls_private_key" "argocd_deploy_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "argocd_deploy_key" {
  repository = "argocd-apps"
  title      = "ArgoCD Apps Deploy Key - Backstage"
  key        = tls_private_key.argocd_deploy_key.public_key_openssh
  read_only  = false
}

resource "github_actions_secret" "argocd_deploy_key" {
  repository       = "backstage"
  secret_name      = "ARGOCD_APPS_DEPLOY_KEY"
  plaintext_value = tls_private_key.argocd_deploy_key.private_key_openssh
}
