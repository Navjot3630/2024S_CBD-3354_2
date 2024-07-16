provider "google" {
  project = var.project_id
  region  = var.region
  # Do not specify serviceAccount here
}

variable "project_id" {
  description = "The project ID to deploy resources into"
  default     = "project897927"
}

variable "region" {
  description = "The region to deploy resources into"
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  default     = "navicluster"
}

variable "node_count" {
  description = "The number of nodes in the cluster"
  default     = 1
}

variable "machine_type" {
  description = "The machine type to use for the cluster"
  default     = "e2-medium"
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
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  network_policy {
    enabled = true
  }

  # Specify the service account for GKE
  node_config {
    service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
  }

  # Optional: Define the GKE node pool to use this service account
  node_pool {
    name = "default-pool"
    node_config {
      service_account = "gke-cluster-admin@project897927.iam.gserviceaccount.com"
    }
  }
}
