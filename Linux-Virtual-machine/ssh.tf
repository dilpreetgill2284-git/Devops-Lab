cat > Linux-Virtual-machine/ssh.tf <<'EOF'
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Use provided key if set; otherwise use the generated one
locals {
  effective_public_key = var.ssh_public_key != "" ? var.ssh_public_key : tls_private_key.vm_ssh.public_key_openssh
}
EOF
