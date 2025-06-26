variable "project_id" {
  description = "The GCP project ID where the GKE cluster will be created."
  type        = string
  default     = "mydevopsproject-464107"
}

variable "region" {
  description = "The GCP region for the GKE cluster (e.g., 'us-central1')."
  type        = string
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "my-gke-cluster"
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

variable "min_node_count" {
  description = "The initial number of nodes in the default node pool."
  type        = number
}

variable "max_node_count" {
  description = "The initial number of nodes in the default node pool."
  type        = number
}

variable "network_name" {
  description = "The name of the existing VPC network."
  type        = string
  default     = "my-first-vpc" # Change this to your VPC's name
}

variable "subnet_name" {
  description = "The name of the existing subnet."
  type        = string
  default     = "asia-south-sn-01" # Change this to your subnet's name
}

variable "ip_range_pods" {
  description = "The name of the existing secondary IP range for pods."
  type        = string
  default     = "pods-range" # Change this to your Pods secondary range name
}

variable "ip_range_services" {
  description = "The name of the existing secondary IP range for services."
  type        = string
  default     = "services-range" # Change this to your Services secondary range name
}
