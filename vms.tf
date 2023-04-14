variable "vms" {
  type    = number
  default = 2
}

resource "google_compute_instance" "default" {
  count        = var.vms
  name         = "terraform-instance-${count.index}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags         = ["web-server", "bar"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
  }
}

