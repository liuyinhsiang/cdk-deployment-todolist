module "my-app-deployment" {
  source                  = "./spa-hosting"
  app-name                = var.app-name
  root_domain_name        = var.root_domain_name
  providers               = { aws = aws, aws.us-east-1 = aws.us-east-1 }
  custom_sub_domain_names = var.custom_sub_domain_names
  always_update_app       = var.always_update_app
}
