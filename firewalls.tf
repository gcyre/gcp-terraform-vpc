resource "google_compute_firewall" "allos-ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.main.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  } 
  source_ranges = ["70.55.8.118/32"]
}
