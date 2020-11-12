variable "aws-access-key" {
  type = string
}

variable "aws-secret-key" {
  type = string
}
variable "aws-region" {
  default = "us-east-1"
  type    = string
}

variable "root_domain_name" {
  type = string
}

variable "app-name" {
  type = string
}

variable "custom_sub_domain_names" {
  type    = list(string)
  default = []
}

variable "always_update_app" {
  type    = bool
  default = false
}

