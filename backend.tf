# backend.tf 

terraform {
  backend "s3" {
    bucket         = "02businessproposal"
    key            = "miniclouddevops/prodution/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking" # Add this line, must match the name above
    encrypt        = true                      # Highly recommended for state file encryption
  }
}
