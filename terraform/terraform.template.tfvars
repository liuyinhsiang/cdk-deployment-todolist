aws-access-key = ""
aws-secret-key = ""
aws-region = ""
custom_sub_domain_names = ["www.YOUR_DOMAIN_NAME", "OR_OTHER_ONES"]
root_domain_name = ""
app-name = "" // In this case it's called 'my-app' (folder name)

always_update_app = true
 // always_update_app: Default false, if true, will run build the app then sync with S3 bucket every time 
// run terraform apply (should be true in order to complete the first time deployment)
