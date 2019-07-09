output "cluster_endpoint" {
  value = "${aws_eks_cluster.this.endpoint}"
}

output "platform_version" {
  value = "${aws_eks_cluster.this.platform_version}"
}

output "version" {
  value = "${aws_eks_cluster.this.version}"
}


