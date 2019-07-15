data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.k8s_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "aws_eks_cluster" "this" {
  name = "${var.cluster_name}"

  depends_on = ["aws_eks_cluster.this"]
}

data "aws_eks_cluster_auth" "this" {
  name = "${data.aws_eks_cluster.this.name}"
}