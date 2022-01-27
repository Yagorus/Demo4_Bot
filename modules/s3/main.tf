
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  
  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
   ignore_changes = [tags,tags_all]
  }

  tags = {
    Name = var.bucket_description
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}