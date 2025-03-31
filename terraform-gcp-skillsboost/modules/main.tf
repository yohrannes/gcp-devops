terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
  backend "gcs" {
    bucket  = "tf-bucket-148962"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

module "instances" {
  source = "./modules/instances"
}

module "storage" {
  source = "./modules/storage"
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "6.0.0"
  # insert the 3 required variables here
  network_name = "tf-vpc-987617"
  project_id = var.project_id
  routing_mode = "GLOBAL"

  subnets = [
      {
          subnet_name           = "subnet-01"
          subnet_ip             = "10.10.10.0/24"
          subnet_region         = var.region
      },
      {
          subnet_name           = "subnet-02"
          subnet_ip             = "10.10.20.0/24"
          subnet_region         = var.region
      },
  ]
}

resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
	network = "projects/${var.project_id}/global/networks/tf-vpc-987617"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}