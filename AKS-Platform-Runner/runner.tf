resource "kubernetes_manifest" "repo_runner" {

  depends_on = [
    time_sleep.wait_for_arc_crds
  ]

  manifest = {
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"
    metadata = {
      name      = "repo-runner"
      namespace = "actions-runner-system"
    }
    spec = {
      replicas = 1
      template = {
        spec = {
          repository = "dilpreetgill2284-git/Devops-Lab"
          labels     = ["self-hosted", "aks"]
        }
      }
    }
  }
}
