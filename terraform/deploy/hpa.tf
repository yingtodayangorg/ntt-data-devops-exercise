resource "kubernetes_horizontal_pod_autoscaler_v2" "hpa" {
  metadata {
    name      = "${local.app_name}-hpa"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.labels_common
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.app.metadata[0].name
    }
    min_replicas = 1
    max_replicas = max(2, var.replicas)
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 60
        }
      }
    }
    metric {
      type = "Resource"
      resource {
        name = "memory"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
  }
}
