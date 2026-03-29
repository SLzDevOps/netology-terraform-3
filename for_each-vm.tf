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
      cpu         = 2
      ram         = 4
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 2
      disk_volume = 15
    }
  ]
}

locals {
  db_vms = {
    for vm in var.each_vm : vm.vm_name => vm
  }
}

resource "yandex_compute_instance" "database" {
  for_each = local.db_vms
  
  name        = "db-${each.value.vm_name}"
  hostname    = "db-${each.value.vm_name}"
  platform_id = "standard-v1"
  zone        = var.default_zone
  
  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }
  
boot_disk {
  initialize_params {
    image_id = data.yandex_compute_image.ubuntu.image_id
    size     = each.value.disk_volume
  }
}
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
  }
  
  depends_on = [yandex_compute_instance.web]
}
