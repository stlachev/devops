terraform {
  backend "s3" {
    bucket = "gpm-tfstatestorage-s3"
    key    = "global/s3/terraform.tfstate"
    region = "eu-central-1"
    encrypt=true
  }
}