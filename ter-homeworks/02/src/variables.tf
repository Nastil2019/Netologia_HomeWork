###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJ3c6d6tZQfiDPRmoqZjFcDZm+e8fS/VgTaYqiwMMEk nastilvasileva@gmail.com"
  description = "ssh-keygen -t ed25519"
}
# --- Образы ---
variable "vm_image_family" {
  description = "Family of the OS image (e.g. ubuntu-2204-lts)"
  type        = string
  default     = "ubuntu-2204-lts"
}

# --- ВМ ---
variable "vm_name_prefix" {
  description = "Prefix for VM names (e.g. vm_web_)"
  type        = string
  default     = "vm_web_"
}

variable "vm_name_suffix" {
  description = "Suffix for VM names (e.g. -prod, -dev)"
  type        = string
  default     = ""
}

variable "vm_platform_id" {
  description = "Platform ID (e.g. standard-v1)"
  type        = string
  default     = "standard-v1"
}

variable "vm_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in GB"
  type        = number
  default     = 2
}

variable "vm_core_fraction" {
  description = "CPU core fraction (1–100)"
  type        = number
  default     = 5
}

variable "vm_preemptible" {
  description = "Whether the instance is preemptible"
  type        = bool
  default     = true
}