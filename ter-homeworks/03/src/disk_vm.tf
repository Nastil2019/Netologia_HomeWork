resource "yandex_compute_disk" "storage_disk" {
  count     = 3
  name      = "storage-disk-${count.index + 1}"
  zone      = var.default_zone
  folder_id = var.folder_id
  size      = var.additional_disk_size
  type      = var.disk_type
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = var.platform_id
  zone        = var.default_zone
  folder_id   = var.folder_id

  resources {
    cores  = var.storage_cpu
    memory = var.storage_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.storage_disk_size
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id  = secondary_disk.value.id
      mode     = "READ_WRITE"
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}