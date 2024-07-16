# terraform/outputs.tf

output "region" {
  description = "The GCP region for the cluster"
  value       = google_container_cluster.my_cluster.location
}

output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = google_container_cluster.my_cluster.name
}
