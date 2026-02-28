resource "yandex_compute_instance" "db" {
  for_each    = local.vm_map
  name        = "db-${each.key}"
  hostname    = "db-${each.key}"
  platform_id = var.platform_id
  zone        = var.default_zone
  folder_id   = var.folder_id

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}