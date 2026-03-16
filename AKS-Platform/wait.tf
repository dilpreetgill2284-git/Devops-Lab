resource "time_sleep" "wait_for_arc_crds" {
  depends_on = [
    helm_release.arc
  ]

  create_duration = "60s"
}
