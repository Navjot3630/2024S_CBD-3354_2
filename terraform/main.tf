provider "google" {
  project = var.project_id
  region  = var.region
  # Credentials should be provided by setting the GOOGLE_APPLICATION_CREDENTIALS environment variable
  # service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
}

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = var.node_count

  node_config {
    machine_type   = var.machine_type
    service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Cluster Autoscaler Configuration
  cluster_autoscaling {
    enable_cluster_autoscaler = true
    # Node pool autoscaling
    autoscaling {
      min_node_count = 1
      max_node_count = 5
    }
  }

  # Network Policy Configuration
  network_policy {
    enabled = true
  }
}

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

  # Node Pool Autoscaler Configuration
  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }
}
