locals {
  app_name      = "devops-api"
  labels_common = {
    "app.kubernetes.io/name"        = local.app_name
    "app.kubernetes.io/managed-by"  = "terraform"
    "app.kubernetes.io/part-of"     = "ntt-devops"
    "app.kubernetes.io/environment" = var.environment
  }
  image_full = "${var.image_repo}:${var.image_tag}"
}
