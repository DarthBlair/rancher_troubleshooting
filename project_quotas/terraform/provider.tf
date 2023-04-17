# Specify needed providers
terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "2.0.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.19.0"
    }
  }
}

# Configure the Rancher2 provider
provider "rancher2" {
  api_url    = var.rancher2_url
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
  insecure = true
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "local"
}
