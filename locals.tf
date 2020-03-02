locals {
  ##
  # Kubeconfig
  ##
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.this.endpoint}
    certificate-authority-data: "${aws_eks_cluster.this.certificate_authority.0.data}"
  name: ${var.cluster_name}
contexts:
- context:
    cluster: ${var.cluster_name}
    user: aws
  name: ${var.cluster_name}
current-context: ${var.cluster_name}
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG

  cluster_log_group = "${format("/aws/eks/%s/cluster", var.cluster_name)}"

  worker_node_log_group = "${format("/aws/eks/%s/node_logs",var.cluster_name)}"
}
