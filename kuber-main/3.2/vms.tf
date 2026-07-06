locals {
  # ID образа Ubuntu 20.04 LTS в Yandex Cloud
  ubuntu_image_id = "fd8vmcue7aajpmeo39kk"
}

# Master-нода
resource "yandex_compute_instance" "master" {
  count       = var.master_count
  name        = "k8s-master-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.master_cpu
    memory        = var.master_memory
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = local.ubuntu_image_id
      type     = "network-ssd"
      size     = 30
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.k8s-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s-sg.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init/master.yaml", {
      ssh_public_key = var.ssh_public_key
      hostname       = "k8s-master-${count.index + 1}"
    })
  }
}

# Worker-ноды
resource "yandex_compute_instance" "worker" {
  count       = var.worker_count
  name        = "k8s-worker-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.worker_cpu
    memory        = var.worker_memory
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = local.ubuntu_image_id
      type     = "network-ssd"
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.k8s-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s-sg.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init/worker.yaml", {
      ssh_public_key = var.ssh_public_key
      hostname       = "k8s-worker-${count.index + 1}"
    })
  }
}