# Выводим инвентарь для Ansible в удобном формате
output "ansible_inventory_ini" {
  description = "Ansible inventory in INI format"
  value = <<EOT
[webservers]
%{for i in range(2)~}
web-${i + 1} ansible_host=${yandex_compute_instance.web[i].network_interface[0].nat_ip_address} fqdn=${yandex_compute_instance.web[i].fqdn}
%{endfor~}

[databases]
%{for vm in yandex_compute_instance.db~}
${vm.name} ansible_host=${vm.network_interface[0].nat_ip_address} fqdn=${vm.fqdn}
%{endfor~}

[storage]
storage ansible_host=${yandex_compute_instance.storage.network_interface[0].nat_ip_address} fqdn=${yandex_compute_instance.storage.fqdn}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa
EOT
}