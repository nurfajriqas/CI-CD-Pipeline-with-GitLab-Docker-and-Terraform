terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

locals {
  mime_types = {
    "css": "text/css"
    "eot": "application/vnd.ms-fontobject"
    "gif": "image/gif"
    "htm": "text/html"
    "jpg": "image/jpeg"
    "js": "text/javascript"
    "png": "image/png"
    "svg": "image/svg+xml"
    "tif": "image/tiff"
    "ttf": "font/sfnt"
    "woff": "application/octet-stream"
  }
}

variable "website_domain_name" {
  description = "The DNS domain name of the website being deployed."
  default = "explorecalifornia.org"
}

resource "random_string" "bucket_name_prefix" {
  length = 8
  upper = false
  special = false
}

resource "aws_s3_bucket" "website" {
  bucket = "${random_string.bucket_name_prefix.result}-${var.website_domain_name}"
}

resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "website" {
  depends_on = [
    aws_s3_bucket_public_access_block.website,
    aws_s3_bucket_ownership_controls.website
  ]
  for_each = fileset("/website", "**/*.*")
  bucket = aws_s3_bucket.website.id
  key = each.value
  source = "/website/${each.key}"
  etag = filemd5("/website/${each.key}")
  acl = "public-read"
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) -1], "text/plain")
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.htm"
  }

  error_document {
    key = "index.htm"
  }
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}
