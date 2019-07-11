resource "local_file" "kubeconfig" {
  content   ="${local.kubeconfig}"
  filename  = "${var.kubconfig_write_path}kubeconfig.yaml"
}

resource "local_file" "certificate_authority" {
  content   = "${base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)}"
  filename  = "${var.certificate_authority_write_path}certAuth.pem"
}


