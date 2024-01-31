locals {
  argocd_values = templatefile("${path.module}/k8s/argocd-values.yaml.tpl", {
    argocd_apps_repository_url        = var.argocd_apps_repository_url
    argocd_host                       = "argocd.${var.base_domain}"
    argocd_sso_client_id              = var.argocd_sso_client_id
    argocd_sso_client_secret          = var.argocd_sso_client_secret
    github_org                        = var.github_org
  })
  argocd_apps_values = templatefile("${path.module}/k8s/argocd-apps-values.yaml.tpl", {
    github_org = var.github_org
  })
  argocd_namespace = templatefile("${path.module}/k8s/argocd-namespace.yaml.tpl", {})
}

resource "tls_private_key" "argocd_deploy_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "argocd_deploy_key" {
  repository = "argocd-apps"
  title      = "ArgoCD Apps Deploy Key"
  key        = tls_private_key.argocd_deploy_key.public_key_openssh
  read_only  = false
}

resource "github_actions_organization_secret" "argocd_deploy_key" {
  secret_name     = "ARGOCD_APPS_DEPLOY_KEY"
  visibility      = "all"
  plaintext_value = tls_private_key.argocd_deploy_key.private_key_openssh
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.51.6"
  namespace        = "argocd"
  wait             = true
  create_namespace = true

  values = [
    local.argocd_values
  ]

  set_sensitive {
    name  = "configs.credentialTemplates.argocd-apps.sshPrivateKey"
    value = tls_private_key.argocd_deploy_key.private_key_openssh
  }

  depends_on = [
    kubectl_manifest.argocd_namespace
  ]
}

resource "helm_release" "argocd_apps" {
  name             = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  version          = "1.4.1"
  namespace        = "argocd"
  wait             = true
  create_namespace = true

  values = [
    local.argocd_apps_values
  ]

  depends_on = [
    helm_release.argocd
  ]
}

resource "kubectl_manifest" "argocd_namespace" {
  yaml_body = local.argocd_namespace
}
