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
