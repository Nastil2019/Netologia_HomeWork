resource "yandex_compute_instance_group" "web_group" {
  name                = "lamp-web-group"
  folder_id           = var.yc_folder_id
  service_account_id  = yandex_iam_service_account.sa.id

  instance_template {
    platform_id = "standard-v3"
    
    resources {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        type     = "network-ssd"
        size     = 15
      }
    }

    network_interface {
      subnet_ids         = [yandex_vpc_subnet.public.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.public_sg.id]
    }

    metadata = {
      user-data = templatefile("${path.module}/cloud-init/web.yaml", {
        ssh_public_key = var.ssh_public_key
        image_url      = "https://${yandex_storage_bucket.bucket.bucket_domain_name}/image.jpg"
      })
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
    startup_duration = 120
  }


  load_balancer {
    target_group_name        = "web-target-group"
    target_group_description = "Target group for LAMP web servers"
  }

   depends_on = [
    yandex_resourcemanager_folder_iam_member.sa_admin,
    yandex_resourcemanager_folder_iam_member.sa_storage
  ]
}