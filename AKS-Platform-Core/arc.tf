resource "helm_release" "arc" {

  name             = "arc"
  namespace        = "actions-runner-system"
  create_namespace = true

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  version    = "0.23.7"

  set {
    name  = "authSecret.create"
    value = "false"
  }

  set {
    name  = "installCRDs"
    value = "true"
  }
}
