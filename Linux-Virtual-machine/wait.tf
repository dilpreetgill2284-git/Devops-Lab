# Wait a bit after PIPs are created to avoid Azure "InvalidResourceReference" races
resource "time_sleep" "after_public_ip" {
  depends_on      = [azurerm_public_ip.public_ip]
  create_duration = "20s"
}
