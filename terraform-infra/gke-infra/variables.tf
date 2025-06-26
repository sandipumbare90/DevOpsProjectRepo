variable "gcp_project_id" {
  description = "The GCP project ID where the GKE cluster will be created."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the GKE cluster (e.g., 'us-central1')."
  type        = string
}

variable "gcp_zone" {
  description = "The GCP zone for the GKE cluster's primary location (e.g., 'us-central1-c')."
  type        = string
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "my-gke-cluster"
}

variable "network_name" {
  description = "The name for the VPC network."
  type        = string
  default     = "gke-network"
}

variable "subnet_name" {
  description = "The name for the subnet."
  type        = string
  default     = "gke-subnet"
}

variable "machine_type" {
  description = "The machine type for the GKE nodes."
  type        = string
  default     = "e2-medium" # A good balance for general workloads
}

variable "initial_node_count" {
  description = "The initial number of nodes in the default node pool."
  type        = number
  default     = 1 # Start small, autoscaling will handle growth
}

