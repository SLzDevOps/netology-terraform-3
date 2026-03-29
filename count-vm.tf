resource "yandex_compute_instance" "web" {
  count = 2
  
  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  platform_id = "standard-v1"
  zone        = var.default_zone
  
resources {
  cores  = var.web_cores
  memory = var.web_memory
}

boot_disk {
  initialize_params {
    image_id = data.yandex_compute_image.ubuntu.image_id
    size     = var.boot_disk_size
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
}
