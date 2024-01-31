data "google_client_config" "provider" {}

data "terraform_remote_state" "gke" {
  backend = "gcs"
  config = {
    bucket  = "${{__GOOGLE_PROJECT_ID__}}-idp-terraform"
    prefix  = "gke/terraform/state"
  }
}

provider "kubernetes" {
  host  = "https://${data.terraform_remote_state.gke.outputs.gke_endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.gke.outputs.gke_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.terraform_remote_state.gke.outputs.gke_endpoint}"
    token = data.google_client_config.provider.access_token

    cluster_ca_certificate = base64decode(
      data.terraform_remote_state.gke.outputs.gke_ca_certificate,
    )

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = "https://${data.terraform_remote_state.gke.outputs.gke_endpoint}"
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.gke.outputs.gke_ca_certificate,
  )
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "github" {
  owner = var.github_org
}