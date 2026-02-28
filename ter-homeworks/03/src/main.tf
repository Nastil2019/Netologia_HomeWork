# Сеть
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "${var.vpc_name}-${var.default_zone}"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Data source для образа Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

locals {
  ssh_public_key = file("${pathexpand("~/.ssh/id_ed25519.pub")}")
  vm_map = { for vm in var.each_vm : vm.vm_name => vm }
}