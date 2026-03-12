resource "helm_release" "arc" {
  name       = "actions-runner-controller"
  namespace  = "kubernetes-runner"

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  # pick a recent stable version; keep it pinned to avoid surprises
  version    = "0.23.6"

  create_namespace = true

  # If you do NOT want ARC to create an empty auth secret on its own:
  # (In your manual setup you created the controller-manager secret yourself.)
  set {
    name  = "authSecret.create"
    value = "false"
  }

  # If ARC needs cert-manager webhooks to be enabled, they already are,
  # because we installed cert-manager above.
}
