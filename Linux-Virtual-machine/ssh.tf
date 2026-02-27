# Generate RSA 4096 keypair only if ssh_public_key is empty
resource "tls_private_key" "vm_ssh" {
  count     = var.ssh_public_key == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Decide which public key to use
locals {
  effective_public_key = var.ssh_public_key != "" ? var.ssh_public_key : (
    length(tls_private_key.vm_ssh) > 0 ? tls_private_key.vm_ssh[0].public_key_openssh : ""
  )
}

# (Optional) save generated keys locally for convenience in Codespaces; ignored by git
resource "local_file" "private_key" {
  count           = var.ssh_public_key == "" ? 1 : 0
  filename        = "${path.module}/.ssh/id_rsa"
  content         = tls_private_key.vm_ssh[0].private_key_pem
  file_permission = "0600"
}

resource "local_file" "public_key" {
  count           = var.ssh_public_key == "" ? 1 : 0
  filename        = "${path.module}/.ssh/id_rsa.pub"
  content         = tls_private_key.vm_ssh[0].public_key_openssh
  file_permission = "0644"
}

# Safe to output public key; keep private key sensitive
output "ssh_public_key_effective" {
  value       = local.effective_public_key
  description = "Public key used for VM(s)"
}

output "ssh_private_key_generated" {
  value       = var.ssh_public_key == "" ? tls_private_key.vm_ssh[0].private_key_pem : null
  sensitive   = true
  description = "Generated private key (only when we generated one)"
}
