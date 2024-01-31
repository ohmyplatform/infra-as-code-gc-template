<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 5.44.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0, < 6.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 5.44.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 5.11.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 2.0.4 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google | 29.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 8.0 |

## Resources

| Name | Type |
|------|------|
| [github_actions_organization_secret.argocd_deploy_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret) | resource |
| [github_actions_secret.gcp_project_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.gcp_service_account](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.gcp_workload_identity_provider](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_repository_deploy_key.argocd_deploy_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [google_iam_workload_identity_pool.github](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_service_account.backstage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.github](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.github](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_key.backstage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_storage_bucket.backstage_techdocs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.backstage_techdocs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [helm_release.acme_webhook](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.argocd_apps](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.sealed_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.argocd_namespace](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argocd_notifications_secrets](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.backstage_namespace](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.backstage_secrets](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.cluster_issuer](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.backstage_postgres_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.backstage_postgres_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.argocd_deploy_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_apps_repository_url"></a> [argocd\_apps\_repository\_url](#input\_argocd\_apps\_repository\_url) | Repository URL that ArgoCD will access to deploy apps | `string` | n/a | yes |
| <a name="input_argocd_notifications_app_id"></a> [argocd\_notifications\_app\_id](#input\_argocd\_notifications\_app\_id) | ArgoCD Notifications GitHub App ID | `string` | n/a | yes |
| <a name="input_argocd_notifications_app_installation_id"></a> [argocd\_notifications\_app\_installation\_id](#input\_argocd\_notifications\_app\_installation\_id) | ArgoCD Notifications GitHub App Installation ID | `string` | n/a | yes |
| <a name="input_argocd_notifications_github_private_key"></a> [argocd\_notifications\_github\_private\_key](#input\_argocd\_notifications\_github\_private\_key) | ArgoCD Notifications GitHub Private key for authentication | `string` | n/a | yes |
| <a name="input_argocd_sso_client_id"></a> [argocd\_sso\_client\_id](#input\_argocd\_sso\_client\_id) | ArgoCD SSO Client ID | `string` | n/a | yes |
| <a name="input_argocd_sso_client_secret"></a> [argocd\_sso\_client\_secret](#input\_argocd\_sso\_client\_secret) | ArgoCD SSO Client Secret | `string` | n/a | yes |
| <a name="input_backstage_auth_github_client_id"></a> [backstage\_auth\_github\_client\_id](#input\_backstage\_auth\_github\_client\_id) | Github client ID for authentication | `string` | n/a | yes |
| <a name="input_backstage_auth_github_client_secret"></a> [backstage\_auth\_github\_client\_secret](#input\_backstage\_auth\_github\_client\_secret) | Github client secret for authentication | `string` | n/a | yes |
| <a name="input_backstage_integration_github_app_id"></a> [backstage\_integration\_github\_app\_id](#input\_backstage\_integration\_github\_app\_id) | Github app ID for integration | `string` | n/a | yes |
| <a name="input_backstage_integration_github_client_id"></a> [backstage\_integration\_github\_client\_id](#input\_backstage\_integration\_github\_client\_id) | Github client ID for integration | `string` | n/a | yes |
| <a name="input_backstage_integration_github_client_secret"></a> [backstage\_integration\_github\_client\_secret](#input\_backstage\_integration\_github\_client\_secret) | Github client secret for integration | `string` | n/a | yes |
| <a name="input_backstage_integration_github_private_key"></a> [backstage\_integration\_github\_private\_key](#input\_backstage\_integration\_github\_private\_key) | Github private key for integration | `string` | n/a | yes |
| <a name="input_backstage_integration_github_webhook_secret"></a> [backstage\_integration\_github\_webhook\_secret](#input\_backstage\_integration\_github\_webhook\_secret) | Github webhook secret for integration | `string` | n/a | yes |
| <a name="input_backstage_techdocs_bucket_name"></a> [backstage\_techdocs\_bucket\_name](#input\_backstage\_techdocs\_bucket\_name) | Techdocs bucket name | `string` | n/a | yes |
| <a name="input_base_domain"></a> [base\_domain](#input\_base\_domain) | Base domain to access the cluster | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the GKE to be created | `string` | `"idp"` | no |
| <a name="input_cluster_subnet_name"></a> [cluster\_subnet\_name](#input\_cluster\_subnet\_name) | Name of the subnet where the GKE cluster will be created | `string` | `"subnet-01"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The Kubernetes version of the masters for the GKE cluster. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"1.27"` | no |
| <a name="input_deploy_key_argocd"></a> [deploy\_key\_argocd](#input\_deploy\_key\_argocd) | Deploy key used by argocd to access repository | `string` | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | Email to use for the certificate | `string` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Github organization to authenticate against | `string` | n/a | yes |
| <a name="input_pods_range_ip_cidr_range"></a> [pods\_range\_ip\_cidr\_range](#input\_pods\_range\_ip\_cidr\_range) | CIDR range of the secondary subnet ip range to use for pods in GKE cluster | `string` | `"192.168.0.0/18"` | no |
| <a name="input_pods_range_name"></a> [pods\_range\_name](#input\_pods\_range\_name) | Name of the secondary subnet ip range to use for pods in GKE cluster | `string` | `"pods-range"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the resources will be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where the resources are going to be created | `string` | `"europe-west1"` | no |
| <a name="input_services_range_ip_cidr_range"></a> [services\_range\_ip\_cidr\_range](#input\_services\_range\_ip\_cidr\_range) | CIDR range of the secondary subnet ip range to use for services in GKE cluster | `string` | `"192.168.64.0/18"` | no |
| <a name="input_services_range_name"></a> [services\_range\_name](#input\_services\_range\_name) | Name of the secondary subnet ip range to use for services in GKE cluster | `string` | `"services-range"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
