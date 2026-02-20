variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 8
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 10
    }
  ]
}

locals {
  ssh_public_key = file("${pathexpand("~/.ssh/id_rsa.pub")}")
  vm_map = { for vm in var.each_vm : vm.vm_name => vm }
}

resource "yandex_compute_instance" "db" {
  for_each    = local.vm_map
  name        = "db-${each.key}"
  zone        = var.default_zone
  folder_id   = var.folder_id

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = "fd82v7qog7ut8f8k9v9c"  # Ubuntu 22.04 LTS
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}