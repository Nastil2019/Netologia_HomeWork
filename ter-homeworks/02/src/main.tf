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
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_web.image_id
      size     = var.vms_resources["web"].hdd_size
      type     = var.vms_resources["web"].hdd_type
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = true
  }

  metadata = var.metadata
}

# Вторая ВМ — db
resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
      size     = var.vms_resources["db"].hdd_size
      type     = var.vms_resources["db"].hdd_type
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = var.metadata
}