resource "helm_release" "kong" {
  count      = var.enable_kong ? 1 : 0
  name       = "kong"
  repository = "https://charts.konghq.com"
  chart      = "kong"
  namespace  = "kong"

  create_namespace = true

  values = [
    <<EOF
ingressController:
  installCRDs: true
admin:
  enabled: true
proxy:
  type: LoadBalancer
EOF
  ]
}
