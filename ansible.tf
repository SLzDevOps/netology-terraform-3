resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      webservers = yandex_compute_instance.web
      databases  = yandex_compute_instance.database
      storage    = [yandex_compute_instance.storage]
    }
  )
  filename = "${path.module}/inventory.ini"
  
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.database,
    yandex_compute_instance.storage
  ]
}
