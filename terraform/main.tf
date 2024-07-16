provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  network_policy {
    enabled = true
  }
}
