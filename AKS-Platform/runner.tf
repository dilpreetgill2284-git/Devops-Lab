resource "kubernetes_manifest" "repo_runner" {

  depends_on = [
    helm_release.arc
  ]
