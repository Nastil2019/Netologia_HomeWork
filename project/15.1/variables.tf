variable "yc_token" {
  description = "OAuth token for Yandex Cloud"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Zone for resources"
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "192.168.10.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "192.168.20.0/24"
}

variable "nat_instance_ip" {
  description = "Internal IP for NAT instance"
  type        = string
  default     = "192.168.10.254"
}

variable "ubuntu_image_id" {
  description = "Ubuntu 20.04 LTS image ID"
  type        = string
  default     = "fd8vmcue7aajpmeo39kk"
}

variable "nat_image_id" {
  description = "NAT instance image ID"
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}