provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

locals {
  subject_alternative_names = concat(["*.${var.root_domain_name}"], var.custom_sub_domain_names)
}

resource "aws_acm_certificate" "certificate" {
  provider          = aws.us-east-1
  domain_name       = var.root_domain_name
  validation_method = var.validation_method

  tags = var.tags
  lifecycle {
    create_before_destroy = true
  }

  subject_alternative_names = local.subject_alternative_names
}

data "aws_route53_zone" "zone" {
  name         = var.root_domain_name
  private_zone = false

  depends_on = [aws_route53_zone.zone]
}

resource "aws_route53_record" "cert_validations" {
  count           = var.validation_method == "DNS" ? length(local.subject_alternative_names) + 1 : 0
  name            = element(aws_acm_certificate.certificate.domain_validation_options.*.resource_record_name, count.index)
  type            = element(aws_acm_certificate.certificate.domain_validation_options.*.resource_record_type, count.index)
  records         = [element(aws_acm_certificate.certificate.domain_validation_options.*.resource_record_value, count.index)]
  ttl             = 60
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.zone.id
}

resource "aws_acm_certificate_validation" "cert_validations" {
  count                   = var.validation_method == "DNS" ? 1 : 0
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = aws_route53_record.cert_validations.*.fqdn
  timeouts {
    create = "120m"
  }
}

