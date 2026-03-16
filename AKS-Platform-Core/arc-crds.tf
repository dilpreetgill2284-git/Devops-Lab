resource "helm_release" "arc_crds" {
  name             = "arc-crds"
  namespace        = "actions-runner-system"
  create_namespace = true

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller-crds"
}
