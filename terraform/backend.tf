terraform {
  backend "s3" {
    bucket = "my-bucket-2323"
    key            = "terraform/terraform.tfstate"
//    key = "main"
    region = "eu-central-1"
//    dynamodb_table = "my-dynamo-db-table-tf"
  }
}