variable "custom_sub_domain_names" {
  type    = list(string)
  default = []
}


variable "root_domain_name" {
  type = string
}


variable "app-name" {
  type = string
}

variable "always_update_app" {
  type    = bool
  default = false
}

variable "validation_method" {
  type    = string
  default = "DNS"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "create_ipv6_record" {
  type    = bool
  default = true
}

variable "create_custom_sub_domains_redirection" {
  type    = bool
  default = true
}
