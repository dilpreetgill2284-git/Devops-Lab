resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace" "arc" {
  metadata {
    name = "kubernetes-runner"
  }
}
