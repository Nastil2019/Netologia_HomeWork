# Создаём 3 одинаковых диска по 1 ГБ
resource "yandex_compute_disk" "storage_disk" {
  count     = 3
  name      = "storage-disk-${count.index + 1}"
  zone      = var.default_zone
  folder_id = var.folder_id
  size      = 1
  type      = "network-hdd"
}

# Создаём одиночную ВМ "storage"
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  zone        = var.default_zone
  folder_id   = var.folder_id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8q1krrgc5pncjckeht"  # Ubuntu 22.04 LTS
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  # Динамически подключаем созданные диски
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id  = secondary_disk.value.id
      mode     = "READ_WRITE"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}