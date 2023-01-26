data "aws_iam_policy_document" "allow_access_to_bucket" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    resources = [
      aws_s3_bucket.calculadora.arn,
      "${aws_s3_bucket.calculadora.arn}/*",
    ]
  }
}