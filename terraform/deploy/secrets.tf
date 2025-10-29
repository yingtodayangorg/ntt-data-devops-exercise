resource "kubernetes_secret" "devops_secrets" {
  metadata {
    name      = "devops-secrets"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.labels_common
  }
  data = {
    JWT_SECRET = var.jwt_secret
  }
  type = "Opaque"
}

resource "kubernetes_secret" "ntt_client_apikey" {
  metadata {
    name      = "ntt-client-apikey"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.labels_common
  }
  data = {
    X_PARSE_REST_API_KEY = var.api_key_value
  }
  type = "Opaque"
}
