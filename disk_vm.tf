resource "yandex_compute_disk" "storage_disk" {
  count = 3
  
  name     = "storage-disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1  # 1 Гб
  block_size = 4096
  
  labels = {
    environment = "storage"
    purpose     = "additional"
  }
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone
  
  resources {
    cores  = 2
    memory = 2
  }
  
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"  # Ubuntu 20.04 LTS
      size     = 10
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }
  
  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
  }
  
  depends_on = [yandex_compute_disk.storage_disk]
}
