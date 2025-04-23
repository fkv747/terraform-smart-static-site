
# 📦 Smart Static Website on AWS (Terraform)

This project builds a secure, scalable, and fast static website on AWS using Terraform. It includes CloudFront, a custom domain via Route 53, HTTPS via ACM, and is structured for clarity and reusability.

## ✅ Features
- Static website hosting via **S3**
- Global delivery using **CloudFront**
- Locked-down access with **Origin Access Identity (OAI)**
- Custom domain with **Route 53**
- Automated **HTTPS with AWS Certificate Manager (ACM)**
- Fully deployed via **modular Terraform**
- Designed for scalability, security, and IaC best practices

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
├── main.tf                     # Root Terraform entry
├── variables.tf
├── outputs.tf
├── backend.tf                 # Optional: for remote state
├── website/
│   └── index.html             # macOS-style UI content
└── modules/
    └── s3-cloudfront/
        ├── main.tf            # S3, CloudFront, OAI, object upload
        ├── variables.tf
        ├── outputs.tf
```

---

### 🛠 Step-by-Step Deployment

#### 1. Initialize Terraform
```bash
terraform init
```

#### 2. Apply Infrastructure
```bash
terraform apply
```
- Choose a globally unique S3 bucket name (e.g., `kev-cloudfront-bucket-2025`)
- Confirm apply when prompted

#### 3. Upload the HTML File Automatically
Handled via Terraform:
```hcl
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = "${path.module}/../../website/index.html"
  content_type = "text/html"
}
```

#### 4. Configure ACM & DNS Validation
Terraform provisions:
- Certificate via `aws_acm_certificate`
- DNS CNAME records via `aws_route53_record`
- Certificate validation via `aws_acm_certificate_validation`

#### 5. Attach ACM to CloudFront for HTTPS
After cert status is "Issued", CloudFront is updated to use:
```hcl
viewer_certificate {
  acm_certificate_arn = aws_acm_certificate.cert.arn
  ssl_support_method  = "sni-only"
}
```

#### 6. Map Your Domain to CloudFront
Alias record added via Route 53:
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

## 🔐 Optional Enhancements
- [ ] Integrate AWS WAF to filter traffic and block bots/IPs
- [ ] Add GitHub Actions for CI/CD
- [ ] Deploy preview environments per pull request

---

## 📸 Screenshots (include these in your GitHub repo or blog)
- [x] Architecture diagram
- [x] Folder structure
- [x] Terraform `apply` success
- [x] CloudFront distribution
- [x] ACM validation
- [x] HTTPS in browser with custom domain

---

## 🧠 Lessons Learned
- Don’t forget to upload `index.html` *after* locking down S3 with OAI
- ACM validation can take longer than expected — always check DNS
- Automating HTTPS and DNS with Terraform is worth the effort

---

## 📘 Project Repo
[terraform-smart-static-site](https://github.com/fkv747/terraform-smart-static-site)

Built with IaC-first principles and designed to scale with future integrations like WAF, CI/CD, and preview workflows.
