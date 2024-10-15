data "aws_iam_role" "glue_crawler" {
  name = "AWSGlueServiceRole-ce6-capstone-group3"
}

resource "aws_glue_catalog_database" "sssw" {
  name = "ce6-group3-capstone-${var.env}-db"
}

resource "aws_glue_catalog_table" "sssw" {
  name          = "ce6-group3-capstone-${var.env}-table"
  database_name = aws_glue_catalog_database.sssw.name
}

resource "aws_glue_crawler" "example" {
  database_name = aws_glue_catalog_database.sssw.name
  name          = "ce6-capstone-group3-${var.env}"
  role          = data.aws_iam_role.glue_crawler.arn
  schedule      = "cron(40 14 * * ? *)"

  provisioner "local-exec" {
    command = "aws glue start-crawler --name ${self.name}"
  }

  s3_target {
    path = "s3://${aws_s3_bucket.bucket.bucket}/output/"
  }
}

