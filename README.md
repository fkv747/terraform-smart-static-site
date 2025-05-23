
# Smart Static Website on AWS (Terraform)

![Terraform](https://img.shields.io/badge/Terraform-1.3%2B-blue)
![AWS](https://img.shields.io/badge/AWS-CloudFront%20%7C%20S3%20%7C%20ACM%20%7C%20WAF-orange)

A secure, scalable, and global static site hosted on AWS — powered entirely by Terraform.

This project uses S3 for storage, CloudFront for distribution, Route 53 for DNS, ACM for HTTPS, and WAF for edge protection. Everything is deployed through Infrastructure as Code.

---

## Demo

📺 **Watch the YouTube demo**  
[Watch the YouTube demo](https://www.youtube.com/watch?v=YOUR_DEMO_LINK)  
_This app was deployed and verified using a custom domain and HTTPS, then turned off to reduce AWS costs. All code and architecture are fully documented below._

[INSERT: Screenshot of browser with live HTTPS version]

---

## Architecture

This diagram summarizes the full AWS-powered architecture, deployed entirely through Terraform:

![Smart Static Website Architecture](./screenshots/smart-static-website.png)

---

## ✅ Features
- Static website hosting via **S3**
- Global delivery using **CloudFront**
- Locked-down access with **Origin Access Identity (OAI)**
- Custom domain with **Route 53**
- Automated **HTTPS with AWS Certificate Manager (ACM)**
- Web Application Firewall (WAF) integration for added security
- Fully deployed via **modular Terraform**

---

## How to Deploy This Project

### Prerequisites
- Terraform >= 1.3.0
- AWS CLI configured
- AWS account with access to Route 53, ACM, and WAF
- A registered domain (e.g. `fkvventures.com`)

### Project Structure
```
smart-static-site/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── website/
│   └── index.html
├── modules/
│   └── s3-cloudfront/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── screenshots/
    ├── architecture.png
    ├── folder-structure.png
    ├── cloudfront-settings.png
    ├── index-preview.png
    └── acm-validation.png
```

---

## Deployment Steps

1. **Initialize Terraform**
```bash
terraform init
```

2. **Apply infrastructure**
```bash
terraform apply
```

- Choose a globally unique S3 bucket name (e.g., `kev-cloudfront-bucket-2025`)
- Confirm apply when prompted

3. **Upload HTML to S3 (Handled in Terraform)**
```hcl
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = "${path.module}/../../website/index.html"
  content_type = "text/html"
}
```

4. **Request and Validate ACM Certificate**
- Terraform provisions DNS records in Route 53
- ACM polls until the cert is issued

5. **Create and Attach WAF to CloudFront**
```hcl
resource "aws_wafv2_web_acl" "main" {
  name        = "static-site-acl"
  scope       = "CLOUDFRONT"
  default_action {
    allow {}
  }

  rule {
    name     = "block-common-bots"
    priority = 1
    action {
      block {}
    }
    statement {
      managed_rule_group_statement {
        name        = "CommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-common-bots"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "static-site-acl"
    sampled_requests_enabled   = true
  }
}

# Attach to CloudFront
web_acl_id = aws_wafv2_web_acl.main.arn
```

6. **Attach HTTPS Certificate to CloudFront**
```hcl
viewer_certificate {
  acm_certificate_arn = aws_acm_certificate.cert.arn
  ssl_support_method  = "sni-only"
}
```

7. **Point Domain to CloudFront**
```hcl
resource "aws_route53_record" "alias" {
  name    = "fkvventures.com"
  type    = "A"
  zone_id = aws_route53_zone.main.zone_id

  alias {
    name                   = aws_cloudfront_distribution.site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
```


---

## What I Learned

This project connected every piece of cloud infrastructure I’ve studied — and forced me to think like an engineer, not just a builder. I went from hosting a static site to securing it behind CloudFront with a locked-down S3 bucket, then layering on a custom domain, HTTPS, and WAF — all using Terraform.

Along the way, I learned:
- How Origin Access Identity (OAI) works behind the scenes
- Why file permissions, object ownership, and bucket policies matter more than they seem
- ACM delays are normal
- How to integrate WAF using managed AWS rule groups for added protection

Most of all, I learned to trust Terraform to build not just infrastructure, but **trust** and **security** into my deployments — and how to stay calm when something breaks.

---

## Project Repo
[terraform-smart-static-site](https://github.com/fkv747/terraform-smart-static-site)

All infrastructure code and screenshots are open source and documented.
