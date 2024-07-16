provider "google" {
  project = var.project_id
  region  = var.region
  # Optional: Add credentials for best practice
  # credentials = file("<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY_JSON>")
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
    # Disk size configuration
    disk_size_gb = 20  # Set disk size to 20 GB
    disk_type    = "pd-ssd"  # Optional: Specify disk type as SSD
  }

  # Enable Network Policy
  network_policy {
    enabled = true
  }

  # Optional: Configure master version
  # master_version = var.master_version
}

resource "google_container_node_pool" "primary_nodes" {
  name               = "${google_container_cluster.primary.name}-nodes"
  location           = var.region
  cluster            = google_container_cluster.primary.name
  node_count         = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
  }

  # Enable Node Pool Autoscaling
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }
}

# Optional: Add network policy provider
# resource "google_container_cluster" "primary" {
#   ...
#   network_policy {
#     provider = "CALICO"
#   }
# }
