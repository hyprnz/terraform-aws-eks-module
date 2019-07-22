provider "kubernetes" {
  version                = "~>1.8"
  host                   = "${aws_eks_cluster.this.endpoint}"
  cluster_ca_certificate = "${base64decode(aws_eks_cluster.this.certificate_authority.0.data)}"
  token                  = "${data.aws_eks_cluster_auth.this.token}"
  load_config_file       = false
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    "mapRoles" = <<MAPROLES
- rolearn: ${aws_iam_role.worker_node.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
- rolearn: ${var.maproles_team_role_arn}
  username: "${var.maproles_username}"
  groups:
    - system:masters
MAPROLES
  }
}
