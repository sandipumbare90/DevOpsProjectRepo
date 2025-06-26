provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region # e.g., "us-central1" or "europe-west1"
  impersonate_service_account = "cicd-sa@mydevopsproject-464107.iam.gserviceaccount.com"
}

