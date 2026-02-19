# --- VM Web Instance Variables ---
variable "vm_web_name" {
  description = "Name of the web VM instance"
  type        = string
  default     = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  description = "Platform ID for the web VM"
  type        = string
  default     = "standard-v1"
}

variable "vm_web_cores" {
  description = "Number of CPU cores for the web VM"
  type        = number
  default     = 2
}

variable "vm_web_memory" {
  description = "Memory in GB for the web VM"
  type        = number
  default     = 2
}

variable "vm_web_core_fraction" {
  description = "CPU core fraction percentage (1–100)"
  type        = number
  default     = 5
}

variable "vm_web_preemptible" {
  description = "Whether the VM is preemptible (spot instance)"
  type        = bool
  default     = true
}

variable "vm_web_image_family" {
  description = "OS image family for the web VM"
  type        = string
  default     = "ubuntu-2004-lts"
}

###2 VM

# --- VM DB Instance Variables ---
variable "vm_db_name" {
  description = "Name of the database VM instance"
  type        = string
  default     = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  description = "Platform ID for the DB VM"
  type        = string
  default     = "standard-v1"
}

variable "vm_db_cores" {
  description = "Number of CPU cores for the DB VM"
  type        = number
  default     = 2
}

variable "vm_db_memory" {
  description = "Memory in GB for the DB VM"
  type        = number
  default     = 2
}

variable "vm_db_core_fraction" {
  description = "CPU core fraction percentage for DB VM"
  type        = number
  default     = 20
}

variable "vm_db_preemptible" {
  description = "Whether the DB VM is preemptible"
  type        = bool
  default     = true
}

variable "vm_db_image_family" {
  description = "OS image family for the DB VM"
  type        = string
  default     = "ubuntu-2004-lts"
}