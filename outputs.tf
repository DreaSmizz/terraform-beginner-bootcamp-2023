#https://registry.terraform.io/providers/hashicorp/random/latest
output "bucket_name" {
    value = aws_s3_bucket.website_bucket.bucket
}