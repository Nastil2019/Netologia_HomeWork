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

variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 1
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 4
}

variable "master_cpu" {
  description = "CPU cores for master node"
  type        = number
  default     = 2
}

variable "master_memory" {
  description = "Memory in GB for master node"
  type        = number
  default     = 4
}

variable "worker_cpu" {
  description = "CPU cores for worker node"
  type        = number
  default     = 2
}

variable "worker_memory" {
  description = "Memory in GB for worker node"
  type        = number
  default     = 4
}