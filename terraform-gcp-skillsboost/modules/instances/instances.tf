resource "google_compute_instance" "tf-instance-1" {

  name         = "tf-instance-1"
  machine_type = "e2-standard-2"
  zone = var.zone

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20250311"
    }
  }

  network_interface {
    network = "tf-vpc-987617"
    subnetwork = "subnet-01"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "e2-standard-2"
  zone = var.zone

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20250311"
    }
  }

  network_interface {
    network = "tf-vpc-987617"
    subnetwork = "subnet-02"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

/* export PROJECT_ID=""
export ZONE=""

terraform import module.instances.google_compute_instance.tf-instance-2 projects/$PROJECT_ID/zones/$ZONE/instances/tf-instance-2;terraform import module.instances.google_compute_instance.tf-instance-1 projects/$PROJECT_ID/zones/$ZONE/instances/tf-instance-1 */