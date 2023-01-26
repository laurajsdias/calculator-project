resource "aws_s3_bucket" "calculadora" {
  bucket = "projeto-calculadora"
}

resource "aws_s3_bucket_website_configuration" "calculadora" {
  bucket = aws_s3_bucket.calculadora.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "calculadora_acl" {
  bucket = aws_s3_bucket.calculadora.id
  acl = "public-read"
}

resource "aws_s3_bucket_policy" "allow_access_to_bucket" {
  bucket = aws_s3_bucket.calculadora.id
  policy = data.aws_iam_policy_document.allow_access_to_bucket.json
}