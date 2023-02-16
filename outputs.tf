output "s3_website_hosting_arn" {
  description = "ARN of the bucket"
  value       = module.s3_website_hosting.arn
}

output "s3_website_hosting_domain" {
  description = "website domain"
  value       = module.s3_website_hosting.domain
}

output "s3_website_hosting_endpoint" {
  description = "website endpoint"
  value       = module.s3_website_hosting.endpoint
}

output "s3_website_hosting_name" {
  description = "name of the bucket which hosts website"
  value       = module.s3_website_hosting.id
}