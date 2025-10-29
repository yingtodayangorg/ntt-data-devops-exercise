resource "kubernetes_namespace" "app" {
  metadata {
    name   = var.namespace
    labels = local.labels_common
  }
}
