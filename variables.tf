###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  sensitive   = true
}

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
  description = "VPC network&subnet name"
}

# Web VM resources
variable "web_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for web VMs"
}

variable "web_memory" {
  type        = number
  default     = 2
  description = "Memory in GB for web VMs"
}

# Disk sizes
variable "boot_disk_size" {
  type        = number
  default     = 10
  description = "Boot disk size in GB for all VMs"
}

variable "additional_disk_size" {
  type        = number
  default     = 1
  description = "Additional storage disk size in GB"
}

variable "disk_block_size" {
  type        = number
  default     = 4096
  description = "Disk block size in bytes"
}

# SSH key path
variable "ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "Path to SSH public key file"
}
