resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  effective_public_key = var.ssh_public_key != "" ? var.ssh_public_key : tls_private_key.vm_ssh.public_key_openssh
}

output "ssh_public_key_effective" {
  value       = local.effective_public_key
  description = "Public key used for the VMs"
}
