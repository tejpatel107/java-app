resource "aws_s3_bucket_versioning" "test_bucket_versioning_policy" {
  bucket = aws_s3_bucket.jar_files_bucket.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "test_bucket_encryption_policy" {
  bucket = aws_s3_bucket.jar_files_bucket.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "jar_files_bucket" {

  bucket = "java-app-jar-files-bucket"

  tags = {
    "Environment" = "development"
    "region"      = "us-east-1"
  }

  tags_all = {
    "Environment" = "development"
    "region"      = "us-east-1"
  }
}
