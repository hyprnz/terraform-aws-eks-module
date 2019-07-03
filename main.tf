locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.this.endpoint}
    certificate-authority-data: ${aws_eks_cluster.this.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
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
}

resource "aws_eks_cluster" "this" {
name        = "${var.cluster_name}"
role_arn    = "${aws_iam_role.cluster_node.arn}"
version     = "${var.k8s_version}"

vpc_config {
  security_group_ids    = ["${aws_security_group.cluster_node.id}"]
  subnet_ids            = "${var.eks_master_subnet_ids}"
  endpoint_private_access = true
  endpoint_public_access  = true
}

enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

depends_on  = [
  "aws_iam_role_policy_attachment.amazon_eks_cluster_policy",
  "aws_iam_role_policy_attachment.amazon_eks_service_policy",
  "aws_cloudwatch_log_group.this"
]
}

