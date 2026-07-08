# VPC
resource "yandex_vpc_network" "network" {
  name = "homework-network"
}

# Публичная подсеть
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.public_subnet_cidr]
}

# Приватная подсеть
resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.private_subnet_cidr]
  route_table_id = yandex_vpc_route_table.nat_route.id
}

# Route table для приватной подсети
resource "yandex_vpc_route_table" "nat_route" {
  name       = "nat-route"
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_instance_ip
  }
}

# Security group для публичной ВМ
resource "yandex_vpc_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public VM"
  network_id  = yandex_vpc_network.network.id

  # SSH доступ
  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  # Разрешаем весь исходящий трафик
  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Security group для приватной ВМ
resource "yandex_vpc_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private VM"
  network_id  = yandex_vpc_network.network.id

  # SSH доступ только из публичной подсети
  ingress {
    protocol       = "TCP"
    description    = "SSH from public subnet"
    v4_cidr_blocks = [var.public_subnet_cidr]
    port           = 22
  }

  # Разрешаем весь исходящий трафик (пойдёт через NAT)
  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}