terraform {
  required_version = ">= 1.6.0"
  required_providers {
    kubernetes = {
    source  = "hashicorp/kubernetes"
    version = ">= 2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

provider "kubectl" {
  load_config_file    = true
  config_path         = var.kubeconfig_path
  apply_retry_count   = 10
  server_side_applied = true
}
