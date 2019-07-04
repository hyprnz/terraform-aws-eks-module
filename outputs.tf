output "cluster_endpoint" {
  value = "${aws_eks_cluster.this.endpoint}"
}

output "certificate_authority" {
  value = "${aws_eks_cluster.this.certificate_authority.0.data}"
}

output "platform_version" {
  value = "${aws_eks_cluster.this.platform_version}"
}

output "version" {
  value = "${aws_eks_cluster.this.version}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}


