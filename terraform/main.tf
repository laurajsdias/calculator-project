provider "aws" {
    region = "sa-east-1"
}

module "s3" {
  source = "./s3"
}