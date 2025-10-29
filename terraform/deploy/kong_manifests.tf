data "kubectl_file_documents" "kong_plugin_docs" {
  content = file("${path.module}/manifests/kong-plugin.yaml")
}

data "kubectl_file_documents" "kong_consumer_docs" {
  content = file("${path.module}/manifests/kong-consumer.yaml")
}

resource "kubectl_manifest" "kong_plugin" {
  count     = var.enable_kong ? 1 : 0
  yaml_body = data.kubectl_file_documents.kong_plugin_docs.documents[0]
  depends_on = [helm_release.kong, kubernetes_namespace.app]
}

resource "kubectl_manifest" "kong_consumer" {
  count     = var.enable_kong ? 1 : 0
  yaml_body = data.kubectl_file_documents.kong_consumer_docs.documents[0]
  depends_on = [helm_release.kong, kubernetes_namespace.app, kubectl_manifest.kong_plugin]
}
