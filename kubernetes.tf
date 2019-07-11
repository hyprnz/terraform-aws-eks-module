provider "kubernetes" {
  host                   = "${data.aws_eks_cluster.this.endpoint}"
  cluster_ca_certificate = "${base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)}"
  token                  = "${data.aws_eks_cluster_auth.this.token}"
  load_config_file       = false
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name        = "aws-auth"
    namespace   = "kube-system"
  }

  data = {
        "mapRoles" = <<MAPROLES
- rolearn: ${aws_iam_role.worker_node.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
MAPROLES
  }
}