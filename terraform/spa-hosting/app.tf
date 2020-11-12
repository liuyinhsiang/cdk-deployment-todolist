resource "null_resource" "build" {
  count = var.always_update_app ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "cd .. && cd ${var.app-name} yarn install && rm -rf build && yarn build"
  }

  depends_on = [aws_s3_bucket.root]
}

resource "null_resource" "deploy" {
  count = var.always_update_app ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "cd .. && aws s3 sync ${var.app-name}/build/ s3://${var.root_domain_name}"
  }

  depends_on = [null_resource.build]
}
