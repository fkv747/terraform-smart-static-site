
# 📦 Smart Static Website on AWS (Terraform)

This project builds a secure, scalable, and fast static website on AWS using Terraform. It follows modern IaC practices and is part of a 5-project AWS portfolio.

## ✅ Features
- Static website hosting via **S3**
- Global delivery with **CloudFront**
- Public access via Origin Access Identity (OAI) — **no ACLs**
- Modular Terraform setup with outputs
- Designed for fast deploy + easy teardown

---

## 🚀 How to Deploy This Project

### 🧱 Prerequisites
- Terraform >= 1.3.0
- AWS CLI configured
- AWS provider version >= 4.46.0

### 📁 Project Structure
```
smart-static-site/
├── main.tf                     # Root Terraform entry
├── variables.tf
├── outputs.tf
├── backend.tf                 # Optional: for remote state
├── website/
│   └── index.html             # Your actual website content
└── modules/
    └── s3-cloudfront/
        ├── main.tf            # S3, CloudFront, OAI, object upload
        ├── variables.tf
        ├── outputs.tf
```

---

### 🛠 Step-by-Step Deployment

#### 1. Initialize the Terraform environment
```bash
terraform init
```

#### 2. Apply the infrastructure
```bash
terraform apply
```
- Choose a unique S3 bucket name (e.g., `kev-cloudfront-bucket-2025`)
- Confirm apply when prompted

#### 3. Upload the `index.html` file to S3 automatically
Terraform uploads the file via this block inside the module:
```hcl
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = "${path.module}/../../website/index.html"
  content_type = "text/html"
}
```

#### 4. Create CloudFront with OAI
- CloudFront fetches from S3 securely
- Public access is only via CloudFront
- S3 policy is restricted to OAI IAM identity

#### 5. Output the CloudFront URL
```bash
terraform output cloudfront_url
```
Result:
```
cloudfront_url = https://d123456abcdef.cloudfront.net
```
✅ Paste that in the browser to view your live static site!

---

## 🧠 AWS Resources Used
| Resource                         | Purpose                          |
|----------------------------------|----------------------------------|
| `aws_s3_bucket`                 | Host the static content          |
| `aws_s3_bucket_website_configuration` | Configure index/error docs       |
| `aws_s3_bucket_public_access_block` | Allow public access for CloudFront only |
| `aws_cloudfront_origin_access_identity` | Restrict S3 access to CloudFront only |
| `aws_cloudfront_distribution`  | Global CDN + security            |
| `aws_s3_bucket_policy`         | OAI read-only access             |
| `aws_s3_object`                | Upload the HTML file             |

---

## 📌 Deployment Notes
- GitHub repo: [terraform-smart-static-site](https://github.com/fkv747/terraform-smart-static-site)
- `.terraform/` folder and binary files are excluded using `.gitignore`
- Git push failed initially due to >100MB provider files — fixed via history cleanup
- Final output is a secure CloudFront URL serving a smart static site

---

## 📸 Screenshots
- [x] Architecture diagram (S3 + CloudFront + OAI)
- [x] Terraform folder structure
- [x] CloudFront distribution screen
- [x] Live site via CloudFront URL

---

## 🧩 Upcoming Additions
- [ ] HTTPS via ACM
- [ ] WAF integration
- [ ] Route53 (custom domain)

---

## 💼 Author
Built by **Kev** as part of a real-world AWS portfolio project.

Stay tuned for the full blog post and LinkedIn article!
