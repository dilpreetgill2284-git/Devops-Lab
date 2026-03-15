terraform {
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }

  }
}

# -------------------------------------
# AZURE PROVIDER (Creates AKS, VMs etc.)
# -------------------------------------
provider "azurerm" {
  features {}
}

# -------------------------------------
# KUBERNETES PROVIDER
# (Lets Terraform talk to AKS)
# -------------------------------------
provider "kubernetes" {

  host = azurerm_kubernetes_cluster.aks.kube_config[0].host

  client_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  )

  client_key = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  )

  cluster_ca_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  )

}

# -------------------------------------
# HELM PROVIDER
# (Lets Terraform run helm install)
# -------------------------------------
provider "helm" {

  kubernetes {

    host = azurerm_kubernetes_cluster.aks.kube_config[0].host

    client_certificate = base64decode(
      azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
    )

    client_key = base64decode(
      azurerm_kubernetes_cluster.aks.kube_config[0].client_key
    )

    cluster_ca_certificate = base64decode(
      azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
    )

  }

}
