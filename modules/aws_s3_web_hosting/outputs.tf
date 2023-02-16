output "id" {
    value = aws_s3_bucket.bucket.id  
}

output "arn" {
    value = aws_s3_bucket.bucket.arn
}

output "acl" {
    value = aws_s3_bucket.bucket.acl  
}

output "domain" {
    value = aws_s3_bucket_website_configuration.bucket.website_domain
}

output "endpoint" {
    value = aws_s3_bucket_website_configuration.bucket.website_endpoint 
}