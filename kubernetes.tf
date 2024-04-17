resource "google_container_cluster" "primary" {
  name     = "primarycluster"
  location = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count = 1
  network = google_compute_network.main.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  networking_mode = "VPC_NATIVE"
  deletion_protection = false
  
  master_authorized_networks_config {}

  node_locations = [
    "us-central1-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    
    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "gcp-terraform-vpc.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "pod-ip-range"
    services_secondary_range_name = "services-ip-range"
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
}


