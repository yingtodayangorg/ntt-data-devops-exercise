resource "kubernetes_service" "svc" {
  metadata {
    name      = "${local.app_name}-svc"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.labels_common
  }
  spec {
    selector = { app = local.app_name }
    port {
      name        = "http"
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }
    type = "ClusterIP"
  }
}
