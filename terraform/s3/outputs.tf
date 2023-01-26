output "s3_website_domain" {
  value = aws_s3_bucket_website_configuration.calculadora.website_endpoint
}


