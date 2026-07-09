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

# Route table для приватной подсети (для выхода в интернет через NAT)
resource "yandex_vpc_route_table" "nat_route" {
  name       = "nat-route"
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_instance_ip
  }
}

# Security group для публичной подсети
resource "yandex_vpc_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public subnet"
  network_id  = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH from internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH internal"
    v4_cidr_blocks = [var.public_subnet_cidr]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Security group для приватной подсети
resource "yandex_vpc_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private subnet"
  network_id  = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH from public subnet"
    v4_cidr_blocks = [var.public_subnet_cidr]
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP from public subnet"
    v4_cidr_blocks = [var.public_subnet_cidr]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Статический IP для NAT-инстанса
resource "yandex_vpc_address" "nat_address" {
  name = "nat-static-ip"
  
  external_ipv4_address {
    zone_id = var.zone
  }
}

# Статический IP для публичной ВМ
resource "yandex_vpc_address" "public_vm_address" {
  name = "public-vm-static-ip"
  
  external_ipv4_address {
    zone_id = var.zone
  }
}