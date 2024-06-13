/*
resource "aws_s3_bucket" "my-terraform-s3-bucket-23" {
  bucket  = "my-bucket-2323"
  tags    = {
    Name           = "MyS3Bucket"
    Environment    = "Production"
  }
}

resource "aws_s3_bucket_acl" "my-terraform-s3-bucket-23-acl" {
  bucket = aws_s3_bucket.my-terraform-s3-bucket-23.id
  acl    = "private"
}
*/