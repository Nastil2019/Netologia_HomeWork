# Локальная переменная для сбора информации о ВМ
locals {
  # Web серверы (из count-vm.tf)
  web_servers = [
    for i in range(2) : {
      name    = "web-${i + 1}"
      nat_ip  = yandex_compute_instance.web[i].network_interface[0].nat_ip_address
      fqdn    = yandex_compute_instance.web[i].fqdn
    }
  ]

  # DB серверы (из for_each-vm.tf)
  db_servers = [
    for vm in yandex_compute_instance.db : {
      name    = vm.name
      nat_ip  = vm.network_interface[0].nat_ip_address
      fqdn    = vm.fqdn
    }
  ]

  # Storage серверы (из disk_vm.tf)
  storage_servers = [
    {
      name    = yandex_compute_instance.storage.name
      nat_ip  = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn    = yandex_compute_instance.storage.fqdn
    }
  ]
}

# Создаем inventory файл для Ansible
resource "local_file" "hosts_inventory" {
  content = templatefile("${path.module}/hosts.tpl", {
    web_servers     = local.web_servers
    db_servers      = local.db_servers
    storage_servers = local.storage_servers
  })
  
  filename = "${path.module}/hosts.ini"
}

# Опционально: создаем YAML версию inventory
resource "local_file" "hosts_yaml" {
  content = templatefile("${path.module}/hosts_yaml.tpl", {
    web_servers     = local.web_servers
    db_servers      = local.db_servers
    storage_servers = local.storage_servers
  })
  
  filename = "${path.module}/hosts.yml"
}