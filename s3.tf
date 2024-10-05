resource "aws_s3_bucket" "bucket" {
  bucket = "ce6-capstone-group3-${var.env}-sssw"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "SSSW/"

}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_s3_bucket" "dev" {
  count  = var.env == "prod" ? 1 : 0
  bucket = "ce6-capstone-group3-dev-sssw"
}

resource "aws_iam_role" "s3_replication_role" {
  count = var.env == "prod" ? 1 : 0
  name  = "s3-replication-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_s3_bucket_replication_configuration" "replication_config" {
  count  = var.env == "prod" ? 1 : 0
  role   = aws_iam_role.s3_replication_role[count.index].arn
  bucket = aws_s3_bucket.bucket.id #source bucket

  rule {
    id     = "replicate-all-objects"
    status = "Enabled"

    # Optional: Replicate only objects with a specific prefix
    filter {
      prefix = "SSSW/"
    }

    destination {
      bucket        = data.aws_s3_bucket.dev[count.index].arn
      storage_class = "STANDARD" # You can change the storage class if needed
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.bucket_versioning,
  ]
}