resource "time_sleep" "after_pip" {
  # Wait a bit after creating public IP(s) to avoid NIC attach race
  depends_on      = [azurerm_public_ip.public_ip]
  create_duration = "20s"
}
