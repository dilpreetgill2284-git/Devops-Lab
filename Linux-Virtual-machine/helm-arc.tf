resource "helm_release" "arc" {
  name       = "actions-runner-controller"
  namespace  = kubernetes_namespace.arc.metadata[0].name

  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  # pick a recent stable version; keep it pinned to avoid surprises
  version    = "0.23.6"

  # If you do NOT want ARC to create an empty auth secret on its own:
  # (In your manual setup you created the controller-manager secret yourself.)
  # We manage the auth secret ourselves (lab: PAT)

 set {
    name  = "authSecret.create"
    value = "false"
  }

  depends_on = [kubernetes_namespace.arc]

  # If ARC needs cert-manager webhooks to be enabled, they already are,
  # because we installed cert-manager above.
}
