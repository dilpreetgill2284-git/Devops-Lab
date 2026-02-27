resource "time_sleep" "after_pip" {
  depends_on      = [azurerm_public_ip.public_ip]
  create_duration = "20s"
}
