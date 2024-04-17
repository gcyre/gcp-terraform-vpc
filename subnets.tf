resource "google_compute_subnetwork" "private" {
  name = "private"
  ip_cidr_range = "10.5.0.0/20"
  region = "us-central1"
  network = google_compute_network.main.id
  private_ip_google_access = true

  dynamic "secondary_ip_range" {
    for_each = local.secondary_ip_ranges

    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}
