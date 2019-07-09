resource "local_file" "kubeconfig" {
  content   ="${local.kubeconfig}"
  filename  = "${var.kubconfig_write_path}kubeconfig.yaml"
}


resource "local_file" "config_map_aws_auth" {
  content   = "${local.config_map_aws_auth}"
  filename  = "${var.config_map_write_path}config_map_aws_auth.yaml"
}

