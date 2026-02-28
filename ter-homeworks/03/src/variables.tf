### === Cloud vars ===
variable "token" {
  type        = string
  description = "OAuth-token"
  sensitive   = true
}

variable "cloud_id" {
  type        = string
  description = "Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Default CIDR"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC name"
}

### === VM Count ===
variable "web_count" {
  description = "Количество web серверов"
  type        = number
  default     = 2
}

### === Resources ===
variable "web_cpu" {
  description = "CPU для web ВМ"
  type        = number
  default     = 2
}

variable "web_memory" {
  description = "Memory для web ВМ (GB)"
  type        = number
  default     = 2
}

variable "storage_cpu" {
  description = "CPU для storage ВМ"
  type        = number
  default     = 2
}

variable "storage_memory" {
  description = "Memory для storage ВМ (GB)"
  type        = number
  default     = 2
}

### === Disk Size ===
variable "web_disk_size" {
  description = "Размер диска для web ВМ (GB)"
  type        = number
  default     = 10
}

variable "storage_disk_size" {
  description = "Размер диска для storage ВМ (GB)"
  type        = number
  default     = 10
}

variable "additional_disk_size" {
  description = "Размер дополнительных дисков (GB)"
  type        = number
  default     = 1
}

variable "disk_type" {
  description = "Тип диска"
  type        = string
  default     = "network-hdd"
}

### === Platform ===
variable "platform_id" {
  description = "Platform ID для ВМ"
  type        = string
  default     = "standard-v1"
}

### === Preemptible ===
variable "preemptible" {
  description = "Прерываемые ВМ"
  type        = bool
  default     = true
}

### === DB Variables ===
variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 8
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 10
    }
  ]
}

### === Security Group Variables ===
variable "security_group_ingress" {
  description = "secrules ingress"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить входящий ssh"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий http"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий https"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
  ]
}

variable "security_group_egress" {
  description = "secrules egress"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить весь исходящий трафик"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}