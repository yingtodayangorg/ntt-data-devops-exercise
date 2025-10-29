output "namespace"     { value = kubernetes_namespace.app.metadata[0].name }
output "image"         { value = local.image_full }
output "service_name"  { value = kubernetes_service.svc.metadata[0].name }
output "ingress_name"  { value = kubernetes_ingress_v1.ing.metadata[0].name }
output "kong_proxy_hint" {
  value       = "Use `kubectl get svc -n kong` and look for kong-proxy EXTERNAL-IP to reach the app."
  description = "Hint to find Kong proxy endpoint"
}
