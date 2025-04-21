
# 📦 Smart Static Website on AWS (Terraform)

This project builds a secure, scalable, and fast static website on AWS using Terraform. It follows modern IaC practices and is part of a 5-project AWS portfolio.

## ✅ Features
- Static website hosting via **S3**
- Global delivery with **CloudFront**
- Public access via bucket policy (no ACLs)
- Modern Terraform syntax with **separate website configuration**
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
        ├── main.tf            # S3 bucket, object upload
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

#### 3. Upload the `index.html` file to S3 automatically (via Terraform resource)

#### 4. Test your static site
Open this URL in your browser:
```
http://<bucket-name>.s3-website-<region>.amazonaws.com
```
Example:
```
http://kev-cloudfront-bucket-2025.s3-website-us-east-1.amazonaws.com
```

---

## 🧠 AWS Resources Used
| Resource                         | Purpose                          |
|----------------------------------|----------------------------------|
| `aws_s3_bucket`                 | Host the static content          |
| `aws_s3_bucket_website_configuration` | Configure index/error docs       |
| `aws_s3_bucket_public_access_block` | Allow public website access      |
| `aws_s3_object`                 | Upload the HTML file             |

---

## 📌 Deployment Notes
- GitHub repo: [terraform-smart-static-site](https://github.com/fkv747/terraform-smart-static-site)
- `.terraform/` folder and binary files are excluded from version control using `.gitignore`
- Git push failed initially due to provider binaries >100MB — resolved by cleaning Git history

---

## 📸 Screenshots
_TODO: Add screenshots of S3, file upload, and live URL test_

---

## 🧩 Upcoming Additions
- [ ] CloudFront Distribution
- [ ] HTTPS via ACM
- [ ] WAF integration
- [ ] Route53 (custom domain)

---

## 💼 Author
Built by **Kev** as part of a real-world AWS portfolio project.

Stay tuned for the full blog post and LinkedIn article!
