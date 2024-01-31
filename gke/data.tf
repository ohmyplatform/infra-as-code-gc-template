data "google_client_config" "default" {}

data "google_compute_zones" "available" {
  region = var.region
  status = "UP"
}

data "google_container_cluster" "cluster" {
  name     = module.gke.name
  location = module.gke.location
}
