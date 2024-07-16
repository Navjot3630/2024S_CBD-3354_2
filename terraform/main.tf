provider "google" {
  project = var.project_id
  region  = var.region
  # serviceAccount is not used here
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = var.node_count

  node_config {
    machine_type   = var.machine_type
    service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Enable or disable Autopilot Mode
  enable_autopilot = false  # Set to true if you want to use Autopilot Mode

  # Configure Cluster Autoscaler
  cluster_autoscaling {
    enable_cluster_autoscaler = true
    min_node_count = 1
    max_node_count = 5
  }

  # Configure Network Policy
  network_policy {
    enabled = true
  }
}

# Define a separate node pool for additional configurations (if needed)
resource "google_container_node_pool" "default" {
  name               = "${google_container_cluster.primary.name}-node-pool"
  location           = var.region
  cluster            = google_container_cluster.primary.name
  initial_node_count = var.node_count

  node_config {
    machine_type   = var.machine_type
    service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Configure Node Pool Autoscaling
  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }
}
