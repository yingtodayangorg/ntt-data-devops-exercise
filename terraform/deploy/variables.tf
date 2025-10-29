variable "kubeconfig_path" {
  description = "Path to kubeconfig file for the target cluster"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy the app"
  type        = string
  default     = "ntt-devops-dev"
}

variable "environment" {
  description = "Environment name (dev|test|prod)"
  type        = string
  default     = "dev"
}

variable "image_repo" {
  description = "Container image repository (e.g., ghcr.io/your-org/nttdevops-flask or local name)"
  type        = string
  default     = "nttdevops-flask"
}

variable "image_tag" {
  description = "Container image tag (e.g., v1.0.0-dev)"
  type        = string
  default     = "latest"
}

variable "image_pull_policy" {
  description = "Image pull policy (Never|IfNotPresent|Always)"
  type        = string
  default     = "IfNotPresent"
}

variable "replicas" {
  description = "Number of replicas for the deployment"
  type        = number
  default     = 2
}

variable "resources" {
  description = "Container resource requests/limits"
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    requests = { cpu = "250m", memory = "256Mi" }
    limits   = { cpu = "500m", memory = "512Mi" }
  }
}

variable "api_key_value" {
  description = "API key value required by the service"
  type        = string
  sensitive   = true
  default     = "2f5ae96c-b558-4c7b-a590-a501ae1c3f6c"
}

variable "jwt_secret" {
  description = "JWT secret for token generation/validation"
  type        = string
  sensitive   = true
  default     = "secret-key-for-devops-api-ntt-data"
}

variable "ingress_host" {
  description = "Hostname for ingress (DNS). Leave empty to skip host rule."
  type        = string
  default     = ""
}

variable "enable_kong" {
  description = "Whether to install Kong via Helm and configure CRDs/Ingress"
  type        = bool
  default     = true
}
