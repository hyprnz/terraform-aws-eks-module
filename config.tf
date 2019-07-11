resource "local_file" "kubeconfig" {
  content   ="${local.kubeconfig}"
  filename  = "${var.kubconfig_write_path}kubeconfig.yaml"
}


