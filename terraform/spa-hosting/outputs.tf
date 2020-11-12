output "root-website-endpoint" {
  value = aws_s3_bucket.root.website_endpoint
}

output "name_servers" {
  value = aws_route53_zone.zone.name_servers
}

