terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.46.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

module "s3_cloudfront" {
  source      = "./modules/s3-cloudfront"
  bucket_name = "kev-cloudfront-bucket-2025"
}
