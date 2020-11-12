resource "aws_route53_zone" "zone" {
  name = var.root_domain_name
}

resource "aws_route53_record" "root-ipv4" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }


}

resource "aws_route53_record" "root-ipv6" {
  count   = var.create_ipv6_record ? 1 : 0
  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.root_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.root_distribution.hosted_zone_id
    evaluate_target_health = false
  }


}

resource "aws_route53_record" "custom_sub_domains_ipv4" {
  count   = length(var.custom_sub_domain_names)
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.custom_sub_domain_names[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.custom_sub_domains_distribution[count.index].domain_name
    zone_id                = aws_cloudfront_distribution.custom_sub_domains_distribution[count.index].hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [aws_cloudfront_distribution.custom_sub_domains_distribution]
}

resource "aws_route53_record" "custom_sub_domains_ipv6" {

  count   = var.create_ipv6_record && var.create_custom_sub_domains_redirection ? length(var.custom_sub_domain_names) : 0
  zone_id = aws_route53_zone.zone.zone_id

  name = var.custom_sub_domain_names[count.index]
  type = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.custom_sub_domains_distribution[count.index].domain_name
    zone_id                = aws_cloudfront_distribution.custom_sub_domains_distribution[count.index].hosted_zone_id
    evaluate_target_health = false
  }

  depends_on = [aws_cloudfront_distribution.custom_sub_domains_distribution]
}

