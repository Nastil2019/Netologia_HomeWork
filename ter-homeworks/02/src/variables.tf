### Cloud vars
variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "default_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type    = string
  default = "develop"
}

### SSH
#variable "vms_ssh_root_key" {
#  type = string
#}

variable "env" {
  type        = string
  default     = "develop"
  description = "Environment: develop, prod, staging, etc."
}

variable "project" {
  type        = string
  default     = "netology"
  description = "Project name"
}

# --- Единая переменная для ресурсов ВМ ---
variable "vms_resources" {
  description = "Resource configuration for VMs: cores, memory, core_fraction, disk"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 5
      hdd_size      = 10
      hdd_type      = "network-nvme"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-nvme"
    }
  }
}

# --- Общая переменная для metadata ---
variable "metadata" {
  description = "Common metadata for all VMs"
  type        = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ41tPw/aNbFDCTSodcQGgA5UvrTvjaMGTTJpYWncIMt win"
  }
}