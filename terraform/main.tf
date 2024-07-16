provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("/workspace/service-account-key.json")
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
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  name       = "node-pool"
  node_count = var.node_count

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}

output "kubernetes_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "kubernetes_cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}
