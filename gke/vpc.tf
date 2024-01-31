module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 8.0"

  project_id   = var.project_id
  network_name = var.project_id
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-03"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = var.pods_range_name
        ip_cidr_range = var.pods_range_ip_cidr_range
      },
      {
        range_name    = var.services_range_name
        ip_cidr_range = var.services_range_ip_cidr_range
      },
    ]
  }
}
