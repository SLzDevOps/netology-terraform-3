output "storage_disks" {
  value = {
    for idx, disk in yandex_compute_disk.storage_disk : disk.name => {
      id          = disk.id
      size        = disk.size
      type        = disk.type
      zone        = disk.zone
      block_size  = disk.block_size
    }
  }
  description = "Information about created storage disks"
}

output "storage_vm" {
  value = {
    id         = yandex_compute_instance.storage.id
    name       = yandex_compute_instance.storage.name
    ip_address = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    disks_attached = [
      for disk in yandex_compute_instance.storage.secondary_disk : disk.disk_id
    ]
  }
  description = "Storage VM information"
}

output "inventory_file_path" {
  value     = local_file.ansible_inventory.filename
  description = "Path to generated Ansible inventory file"
}

#output "inventory_content" {
#  value     = file(local_file.ansible_inventory.filename)
#  description = "Content of generated Ansible inventory file"
#  sensitive = true
#}
