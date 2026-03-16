resource "helm_release" "arc" {

  depends_on = [
    helm_release.arc_crds
  ]

  name             = "arc"
  namespace        = "actions-runner-system"
  create_namespace = true

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"

  set {
    name  = "authSecret.create"
    value = "false"
  }
}
