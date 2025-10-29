resource "kubernetes_ingress_v1" "ing" {
  metadata {
    name      = "${local.app_name}-ingress"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = local.labels_common
    annotations = {
      "konghq.com/plugins" = "key-auth-plugin"
    }
  }
  spec {
    ingress_class_name = "kong"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.svc.metadata[0].name
              port { number = 8080 }
            }
          }
        }
      }
    }
  }
}
