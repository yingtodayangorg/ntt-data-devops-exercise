resource "helm_release" "kong" {
  count      = var.enable_kong ? 1 : 0
  name       = "kong"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = "kong"

  create_namespace = true

  set {
    name  = "ingressController.installCRDs"
    value = "true"
  }

  set {
    name  = "admin.enabled"
    value = "true"
  }

  set {
    name  = "proxy.type"
    value = "LoadBalancer"
  }
}
