terraform {
  backend "s3" {
    bucket = "my-bucket-2323"
    key    = "terraform/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "tf-backend-lock"
  }
}