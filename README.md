
# 📦 Smart Static Website on AWS (Terraform)

![Terraform](https://img.shields.io/badge/terraform-v1.3%2B-blue?style=flat-square&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-deployed-orange?style=flat-square&logo=amazonaws)
![Status](https://img.shields.io/badge/status-production--ready-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-lightgrey?style=flat-square)

This project builds a secure, scalable, and fast static website on AWS using Terraform. It includes CloudFront, a custom domain via Route 53, HTTPS via ACM, and is structured for clarity and reusability.

## ✅ Features
- Static website hosting via **S3**
- Global delivery using **CloudFront**
- Locked-down access with **Origin Access Identity (OAI)**
- Custom domain with **Route 53**
- Automated **HTTPS with AWS Certificate Manager (ACM)**
- Fully deployed via **modular Terraform**
- Designed for production-grade deployment and learning showcase

---

## 🚀 How to Deploy This Project

### 🧱 Prerequisites
- Terraform >= 1.3.0
- AWS CLI configured
- AWS account with access to Route 53 and ACM
- A registered domain (e.g. `fkvventures.com`)

### 📁 Project Structure
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

## 🛠 Deployment Steps

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

5. **Attach HTTPS Certificate to CloudFront**
```hcl
viewer_certificate {
  acm_certificate_arn = aws_acm_certificate.cert.arn
  ssl_support_method  = "sni-only"
}
```

6. **Point Domain to CloudFront**
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

## 📸 Screenshots
All screenshots are stored in `/screenshots`:
- `architecture.png`
- `folder-structure.png`
- `cloudfront-settings.png`
- `index-preview.png`
- `acm-validation.png`

---

## 💡 What I Learned

This project connected every piece of cloud infrastructure I’ve studied — and forced me to think like an engineer, not just a builder. I went from hosting a static site to securing it behind CloudFront with a locked-down S3 bucket, then layering on a custom domain and fully automated DNS-validated HTTPS using Terraform.

Along the way, I learned:
- How Origin Access Identity (OAI) works behind the scenes
- Why file permissions, object ownership, and bucket policies matter more than they seem
- How to debug slow DNS propagation and ACM delays — without panicking

Most of all, I learned to trust Terraform to build not just infrastructure, but **trust** and **security** into my deployments — and how to stay calm when something breaks.

---

## 📘 Project Repo
[terraform-smart-static-site](https://github.com/fkv747/terraform-smart-static-site)

All infrastructure code and screenshots are open source and documented.
