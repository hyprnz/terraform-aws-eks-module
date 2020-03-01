data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh.tpl")}"

  vars {
    log_group_name             = "${local.worker_node_log_group}"
    eks_cluster_endpoint       = "${aws_eks_cluster.this.endpoint}"
    eks_cluster_cert_auth_data = "${aws_eks_cluster.this.certificate_authority.0.data}"
    eks_cluster_name           = "${var.cluster_name}"
  }
}