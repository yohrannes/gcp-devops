resource "google_storage_bucket" "storage-bucket" {
  name          = "tf-bucket-148962"
  location      = "us"
  force_destroy = true
  uniform_bucket_level_access = true
}