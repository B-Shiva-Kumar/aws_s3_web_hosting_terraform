provider "aws" {
  region = var.region

  default_tags {
    tags = {
      aws_s3 = "aws s3 website hosting"
    }
  }
}

module "s3_website_hosting" {
  source = ".\\modules\\aws_s3_web_hosting"
  # version = "version recommended to specify for realtime projects"

  bucket_prefix = "aws-s3-web-hosting--"

  documents = {
    terraform_managed_files = true
    www_path                = "${path.root}/www"
  }


  cors_rules = [
    {
      allowed_headers = ["*"],
      allowed_methods = ["PUT", "POST"],
      allowed_origins = ["https://test.example.com"]
      expose_headers  = ["ETag"],
      max_age_seconds = 3000
    },

    {
      allowed_methods = ["GET"],
      allowed_origins = ["*"]
    }
  ]


  tags = {
    terraform     = "true"
    environment   = "dev"
    public-bucket = true
  }

}