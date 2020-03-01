output "cluster_name" {
  description = "Name of the EKS Cluster"
  value       = "${aws_eks_cluster.this.name}"
}

output "cluster_endpoint" {
  description = "EKS control plane endpoint"
  value       = "${aws_eks_cluster.this.endpoint}"
}

output "platform_version" {
  description = "EKS platform version"
  value       = "${aws_eks_cluster.this.platform_version}"
}

output "version" {
  description = "EKS Kubernetes version"
  value       = "${aws_eks_cluster.this.version}"
}

output "cluster_config" {
  description = "Kube config file of the current cluster"
  value       = "${local.kubeconfig}"
  sensitive   = true
}


