resource "aws_s3_bucket" "root" {
  bucket        = var.root_domain_name
  acl           = "public-read"
  force_destroy = true
  policy        = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "PublicRead",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${var.root_domain_name}/*"
        }
    ]
}
POLICY

  website {
    index_document = "index.html"
    error_document = "index.html"

  }
}


resource "aws_s3_bucket" "custom_sub_domains" {
  count         = length(var.custom_sub_domain_names)
  bucket        = var.custom_sub_domain_names[count.index]
  acl           = "public-read"
  force_destroy = true
  policy        = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "PublicRead",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${var.custom_sub_domain_names[count.index]}/*"
        }
    ]
}
POLICY

  website {
    redirect_all_requests_to = "https://${var.root_domain_name}"
  }
}



