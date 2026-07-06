output "master_ip" {
  value       = yandex_compute_instance.master[*].network_interface[0].nat_ip_address
  description = "Public IP addresses of master nodes"
}

output "worker_ip" {
  value       = yandex_compute_instance.worker[*].network_interface[0].nat_ip_address
  description = "Public IP addresses of worker nodes"
}

output "master_internal_ip" {
  value       = yandex_compute_instance.master[*].network_interface[0].ip_address
  description = "Internal IP addresses of master nodes"
}

output "worker_internal_ip" {
  value       = yandex_compute_instance.worker[*].network_interface[0].ip_address
  description = "Internal IP addresses of worker nodes"
}