output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.site_cdn.domain_name}"
}
