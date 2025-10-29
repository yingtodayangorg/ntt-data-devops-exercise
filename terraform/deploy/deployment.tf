resource "kubernetes_deployment" "app" {
  metadata {
    name      = local.app_name
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.labels_common
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = { app = local.app_name }
    }
    template {
      metadata {
        labels = merge(local.labels_common, { app = local.app_name })
      }
      spec {
        container {
          name              = local.app_name
          image             = local.image_full
          image_pull_policy = var.image_pull_policy
          port { container_port = 8080 }
          env {
            name  = "API_KEY_VALUE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.ntt_client_apikey.metadata[0].name
                key  = "X_PARSE_REST_API_KEY"
              }
            }
          }
          env {
            name  = "JWT_SECRET"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.devops_secrets.metadata[0].name
                key  = "JWT_SECRET"
              }
            }
          }
          env { name = "ENVIRONMENT" value = var.environment }
          resources {
            limits   = var.resources.limits
            requests = var.resources.requests
          }
          liveness_probe {
            http_get { path = "/health"; port = 8080 }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
          readiness_probe {
            http_get { path = "/health"; port = 8080 }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}
