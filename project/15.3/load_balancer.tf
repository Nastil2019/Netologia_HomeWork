resource "yandex_lb_network_load_balancer" "nlb" {
  name = "web-network-load-balancer"

  listener {
    name        = "web-listener"
    port        = 80
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.web_group.load_balancer[0].target_group_id

    healthcheck {
      name = "tcp-check"
      tcp_options {
        port = 80
      }
    }
  }
}