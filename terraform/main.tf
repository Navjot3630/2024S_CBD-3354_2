provider "google" {
  project = var.project_id
  region  = var.region
  # Added credentials field for best practice
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
  }

  # Enable Autopilot Mode or configure Node Pool Autoscaling
  # Uncomment one of the following blocks based on your requirement

  # For Autopilot Mode
  # autopilot {
  #   enabled = true
  # }

  # For Standard Mode with Node Pool Autoscaling
  node_autoscaling {
    enabled = true
    min_node_count = 1
    max_node_count = 5
  }

  network_policy {
    enabled = true
  }

  # Optional: Configure master version
  # master_version = var.master_version

  # Optional: Enable network policy
  # network_policy {
  #   provider = "CALICO"
  # }
}
