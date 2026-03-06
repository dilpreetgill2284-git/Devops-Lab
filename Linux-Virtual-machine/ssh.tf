
# We do not generate keys in Terraform. 
# CI creates the public key file and we read it from var.ssh_public_key_path.

output "ssh_public_key_effective" {
  value       = file(var.ssh_public_key_path)
  description = "Public key used for the VMs (read from the path provided)"
}
