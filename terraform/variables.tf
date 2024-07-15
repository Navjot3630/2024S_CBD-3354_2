variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region where the GKE cluster will be created"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "chatapp"
}

variable "node_count" {
  description = "Number of initial nodes in the GKE cluster"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "The type of machine to use for the nodes in the GKE cluster"
  type        = string
  default     = "e2-medium"
}

variable "preemptible" {
  description = "Whether to use preemptible VMs for the node pool"
  type        = bool
  default     = true
}
