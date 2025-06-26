data "google_compute_network" "existing_vpc" {
  name    = var.network_name
  project = var.project_id # Explicitly specify project for data source
}

data "google_compute_subnetwork" "existing_gke_subnet" {
  name    = var.subnet_name
  region  = var.region
  project = var.project_id # Explicitly specify project for data source
  network = data.google_compute_network.existing_vpc.name # Link to the data source for the network
}
resource "google_container_cluster" "primary_gke_cluster" {
  name                     = var.cluster_name
  location                 = var.gcp_region # For zonal cluster, use zone; for regional, use region
  project                  = var.gcp_project_id
  network                  = data.google_compute_network.existing_vpc.self_link
  subnetwork               = data.google_compute_subnetwork.existing_gke_subnet.self_link

  workload_identity_config {
  }

  release_channel {
    channel = "REGULAR"
  }

  autoscaling {
    location_policy = "ANY" # Use "ANY" for regional clusters to scale across zones
  }

  ip_allocation_policy {
    cluster_secondary_range_name =  var.ip_range_pods# gke-pods
    services_secondary_range_name = var.ip_service_ranges # gke-services
  }

  initial_node_count = var.initial_node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 100 # Default disk size
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform", # Broad scope, refine for production
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only", # Required for fetching container images
    ]

    service_account = google_service_account.gke_node_sa.email

    workload_metadata_config {
      mode = "GKE_METADATA" # Recommended mode for Workload Identity
    }
  }
  node_pool_autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

}

resource "google_service_account" "gke_node_sa" {
  account_id   = "${var.cluster_name}-node-sa"
  display_name = "Service Account for GKE Node Pool"
  project      = var.gcp_project_id
}

resource "google_project_iam_member" "gke_node_sa_roles" {
  project = var.gcp_project_id
  role    = "roles/logging.logWriter" # Allows writing logs
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_sa_monitoring_viewer" {
  project = var.gcp_project_id
  role    = "roles/monitoring.metricWriter" # Allows sending metrics
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_sa_container_registry_reader" {
  project = var.gcp_project_id
  role    = "roles/containerregistry.ServiceAgent" # Allows pulling images from Container Registry
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_sa_workload_identity_user" {
  project = var.gcp_project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}


