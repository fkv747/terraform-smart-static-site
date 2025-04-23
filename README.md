
# 📦 Smart Static Website on AWS (Terraform)

![Terraform](https://img.shields.io/badge/IaC-Terraform-5C4EE5?logo=terraform)
![AWS](https://img.shields.io/badge/Cloud-AWS-232F3E?logo=amazon-aws)
![HTTPS](https://img.shields.io/badge/Secure-HTTPS-green)
![Status](https://img.shields.io/badge/Status-In_Progress-yellow)

A secure, scalable, and global static site hosted on AWS — powered entirely by Terraform.

This project uses S3 for storage, CloudFront for distribution, Route 53 for DNS, ACM for HTTPS, and WAF for edge protection. Everything is deployed through Infrastructure as Code.

...

📘 Repository

[terraform-smart-static-site](https://github.com/fkv747/terraform-smart-static-site)

Everything in this project is reproducible. Just plug in your domain name and go.

---

## 🧩 Next Steps (Optional Enhancements)

- [ ] Add WAF with IP rate limiting and geo-based restrictions
- [ ] Add CI/CD pipeline for content updates
- [ ] Add preview environments using pull requests + S3 buckets
