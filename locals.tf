provider "local" {
  version = "~>1.3"
}

locals {
  ##
  # Kubeconfig
  ##
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.this.endpoint}
  name: ${var.cluster_name}
contexts:
- context:
    cluster: ${var.cluster_name}
    user: aws
  name: jarden_aws_eks_uat
current-context: jarden_aws_eks_uat
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

##
# Worker node user data payload
##
  worker_node_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.this.endpoint}' --b64-cluster-ca '${aws_eks_cluster.this.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA

}