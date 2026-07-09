# NAT-инстанс
resource "yandex_compute_instance" "nat" {
  name        = "nat-instance"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
      type     = "network-ssd"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    ip_address         = var.nat_instance_ip
    nat_ip_address     = yandex_vpc_address.nat_address.external_ipv4_address[0].address
    security_group_ids = [yandex_vpc_security_group.public_sg.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init/nat.yaml", {
      ssh_public_key = var.ssh_public_key
    })
  }

  lifecycle {
    ignore_changes = [network_interface[0].nat_ip_address]
  }
}

# Публичная ВМ
resource "yandex_compute_instance" "public_vm" {
  name        = "public-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      type     = "network-ssd"
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat_ip_address     = yandex_vpc_address.public_vm_address.external_ipv4_address[0].address
    security_group_ids = [yandex_vpc_security_group.public_sg.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init/ubuntu.yaml", {
      ssh_public_key = var.ssh_public_key
    })
  }

  depends_on = [yandex_compute_instance.nat]

  lifecycle {
    ignore_changes = [network_interface[0].nat_ip_address]
  }
}

# Приватная ВМ
resource "yandex_compute_instance" "private_vm" {
  name        = "private-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      type     = "network-ssd"
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.private_sg.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init/ubuntu.yaml", {
      ssh_public_key = var.ssh_public_key
    })
  }

  depends_on = [yandex_compute_instance.public_vm]
}