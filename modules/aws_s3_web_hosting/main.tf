resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  bucket_prefix = var.bucket_prefix

  tags = var.tags
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = var.bucket_acl
}


resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.documents.index_document_suffix
  }

  error_document {
    key = var.documents.error_document_key
  }
}


resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
      },
    ]
  })
}


module "template_files" {
  source  = "hashicorp/dir/template"
  version = "1.0.2"

  base_dir = var.documents.www_path != null ? var.documents.www_path : "${path.module}/www"
}


resource "aws_s3_bucket_object" "bucket" {
    
    for_each = var.documents.terraform_managed_files ? module.template_files.files : {}
    
    bucket     = aws_s3_bucket.bucket.id
    
    key          = each.key
    source       = each.value.source_path
    content      = each.value.content
    etag         = each.value.digests.md5
    content_type = each.value.content_type    
}


resource "aws_s3_bucket_cors_configuration" "bucket" {

    count = length(var.cors_rules) > 0 ? 1 : 0
    bucket = aws_s3_bucket.bucket.id

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST"]
        allowed_origins = ["https://s3-website-test.hashicorp.com"]
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }

    cors_rule {
        allowed_methods = ["GET"]
        allowed_origins = ["*"]
    }
}