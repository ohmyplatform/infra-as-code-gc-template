locals {
  ingress_nginx_values = templatefile("${path.module}/ingress/ingress-nginx/values.yaml.tpl", {})
  cert_manager_values  = templatefile("${path.module}/ingress/cert-manager/values.yaml.tpl", {})
  cluster_issuer = templatefile("${path.module}/ingress/cluster-issuer.yaml.tpl", {
    email = var.email
  })
}

resource "kubectl_manifest" "cluster_issuer" {
  yaml_body = local.cluster_issuer
  depends_on = [
    helm_release.cert_manager
  ]
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.8.3"
  namespace        = "ingress"
  wait             = true
  create_namespace = true
  values = [
    local.ingress_nginx_values
  ]
  depends_on = [
    module.gke
  ]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.13.1"
  namespace        = "cert-manager"
  wait             = true
  create_namespace = true
  values = [
    local.cert_manager_values
  ]

  depends_on = [
    helm_release.ingress_nginx
  ]
}
