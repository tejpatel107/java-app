resource "aws_s3_bucket" "backend-bucket" {
    bucket = "java-app-iac-backend-bucket"
}

resource "aws_s3_bucket_versioning" "backend-bucket-versioning-policy" {
  bucket = aws_s3_bucket.backend-bucket.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend-bucket-encryption-policy" {
  bucket = aws_s3_bucket.backend-bucket.id

  rule {

    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "backend-table" {
  name = "java-app-backend-state-lock"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "java-app-iac-backend-bucket" # S3 bucket name
    key            = "terraform.tfstate"      # Path to store state file
    region         = "us-east-1"              # S3 bucket region
    dynamodb_table = "java-app-backend-state-lock"     # Optional - for state locking
    encrypt        = true                     # Encrypt state at rest
  }
}