# The module is like a mini self-contained unit we can reuse or test in isolation.
# So we finish the module setup first, then wire it into the root later.

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name



  tags = {
    Name = "Smart Static Site"
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html" # The default page when someone visits the root (e.g. /)
  }

  error_document {
    key = "index.html" # The page shown for any 404 or broken links
  }
# If a user visits https://your-bucket.s3-website-region.amazonaws.com/, S3 will automatically serve index.html.
# If they go to a broken path like /about.html and it doesn’t exist, S3 will also show index.html (or any other error file you define).

}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
# 🧠 When Should You Combine Services in One Module?
# ✅ Combine Services When…	                                            ❌ Separate Services When…
# They're tightly related (e.g. S3 + CloudFront)	                    Services are used in multiple projects
# You want to reuse the whole combo	                                    You want reusability for a single piece (e.g. WAF policy)
# They deploy together (need same lifecycle)	                        You might mix/match parts independently later
# The logic is tightly coupled (e.g. CloudFront needs S3 bucket ARN)	You're building more complex, modular architectures
