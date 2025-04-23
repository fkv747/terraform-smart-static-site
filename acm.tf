resource "aws_acm_certificate" "cert" {
  domain_name               = "fkvventures.com"
  validation_method         = "DNS"
  subject_alternative_names = ["www.fkvventures.com"]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Static Site Cert"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = aws_route53_zone.main.zone_id
  records = [each.value.record]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert" {
 certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# 🗺️ Domain = The Land
# 🌐 CloudFront = The Gated Community
# 🛂 ACM Validation = The Notary