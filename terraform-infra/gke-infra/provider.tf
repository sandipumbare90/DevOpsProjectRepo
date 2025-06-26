provider "google" {
  project = var.project_id
  region  = var.region # e.g., "us-central1" or "europe-west1"
  impersonate_service_account = "cicd-sa@mydevopsproject-464107.iam.gserviceaccount.com"
}

