resource "yandex_compute_instance" "web" {
  count       = 2
  name        = "web-${count.index + 1}"
  zone        = var.default_zone
  folder_id   = var.folder_id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd82v7qog7ut8f8k9v9c"  # Ubuntu 22.04 LTS
      size     = 10
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

  depends_on = [yandex_compute_instance.db]
}