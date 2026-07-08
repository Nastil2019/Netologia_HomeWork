output "public_vm_ip" {
  value       = yandex_compute_instance.public_vm.network_interface[0].nat_ip_address
  description = "Public IP of public VM"
}

output "private_vm_internal_ip" {
  value       = yandex_compute_instance.private_vm.network_interface[0].ip_address
  description = "Internal IP of private VM"
}

output "nat_instance_ip" {
  value       = yandex_compute_instance.nat.network_interface[0].ip_address
  description = "Internal IP of NAT instance"
}

output "nat_instance_public_ip" {
  value       = yandex_compute_instance.nat.network_interface[0].nat_ip_address
  description = "Public IP of NAT instance"
}

output "ssh_to_private_vm" {
  value       = "ssh -J yc-user@${yandex_compute_instance.public_vm.network_interface[0].nat_ip_address} yc-user@${yandex_compute_instance.private_vm.network_interface[0].ip_address}"
  description = "Command to SSH to private VM via public VM"
}