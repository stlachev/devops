terraform {
  backend "s3" {
    bucket = "gpm-tfstatestorage-s3"
    key    = "global/s3/terraform.tfstate"
    region = var.aws_region_name
    encrypt=true
  }
}