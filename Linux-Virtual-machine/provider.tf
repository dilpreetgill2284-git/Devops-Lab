terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.113"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

# Azure provider (unchanged)
provider "azurerm" {
  features {}
}

# Helm provider → tells Terraform how to talk to your Minikube cluster
provider "helm" {
  kubernetes {
    # Use the same kubeconfig kubectl uses. Adjust path if needed.
    config_path = "~/.kube/config"
  }
}
