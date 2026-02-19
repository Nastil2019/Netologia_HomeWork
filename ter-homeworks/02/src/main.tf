# VPC
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop-a" {
  name           = "${var.vpc_name}-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = "${var.vpc_name}-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# Образы
data "yandex_compute_image" "ubuntu_web" {
  family = var.vm_web_image_family
}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image_family
}

# Первая ВМ — web
resource "yandex_compute_instance" "web" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  zone        = "ru-central1-a"

  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_web.image_id
      size     = 10
      type     = "network-nvme"
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

# Вторая ВМ — db
resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = "ru-central1-b"

  resources {
    cores         = var.vm_db_cores          # = 2
    memory        = var.vm_db_memory         # = 2
    core_fraction = var.vm_db_core_fraction  # = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
      size     = 10
      type     = "network-nvme"
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}