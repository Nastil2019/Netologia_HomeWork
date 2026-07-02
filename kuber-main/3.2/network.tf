resource "yandex_vpc_network" "k8s-network" {
  name = "k8s-network"
}

resource "yandex_vpc_subnet" "k8s-subnet" {
  name           = "k8s-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.k8s-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_security_group" "k8s-sg" {
  name        = "k8s-sg"
  description = "Security group for Kubernetes cluster"
  network_id  = yandex_vpc_network.k8s-network.id

  # SSH доступ
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  # Kubernetes API
  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }

  # etcd
  ingress {
    protocol       = "TCP"
    description    = "etcd"
    v4_cidr_blocks = ["192.168.10.0/24"]
    from_port      = 2379
    to_port        = 2380
  }

  # Kubelet
  ingress {
    protocol       = "TCP"
    description    = "Kubelet"
    v4_cidr_blocks = ["192.168.10.0/24"]
    port           = 10250
  }

  # NodePort
  ingress {
    protocol       = "TCP"
    description    = "NodePort range"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}