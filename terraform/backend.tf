terraform {
  backend "s3" {
    # Update these values before running `terraform init`.
    # This backend is intentionally configured WITHOUT DynamoDB locking.
    bucket = "google-ms-demo-67"
    key    = "google-microservices-demo-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}

