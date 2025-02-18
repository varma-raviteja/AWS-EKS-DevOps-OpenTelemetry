provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_stateraviteja" {
  bucket = "demo-terraform-eks-state-bucketravitejavarma"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "terraform_stateraviteja" {
  bucket = aws_s3_bucket.terraform_stateraviteja.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_stateraviteja" {
  bucket = aws_s3_bucket.terraform_stateraviteja.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-eks-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}