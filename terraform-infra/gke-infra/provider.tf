provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region # e.g., "us-central1" or "europe-west1"
  zone    = var.gcp_zone   # e.g., "us-central1-c" or "europe-west1-b"
}

