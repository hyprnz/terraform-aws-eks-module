##
# Cluster node roles and policy bindings
##
resource "aws_iam_role" "cluster_node" {
  name = "${var.cluster_name}-cluster-node"

  assume_role_policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
  {
    "Effect": "Allow",
    "Principal": {
      "Service": "eks.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
  }
]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.cluster_node.name}"
}

resource "aws_iam_role_policy_attachment" "amazon_eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.cluster_node.name}"
}

##
# Worker node roles and policy bindings
##

resource "aws_iam_role" "worker_node" {
  name = "${var.cluster_name}-worker-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "worker_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.worker_node.name}"
}

resource "aws_iam_role_policy_attachment" "worker_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.worker_node.name}"
}

resource "aws_iam_role_policy_attachment" "worker_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.worker_node.name}"
}

resource "aws_iam_instance_profile" "eks_worker_node" {
  name = "${var.cluster_name}_worker_node"
  role = "${aws_iam_role.worker_node.name}"
}

resource "aws_iam_policy" "eks_worker_kube2iam" {
  count = "${var.supports_kube2iam ? 1 : 0}"

  name        = "EKSWorkerKube2IamAssumeRolePolicy"
  description = "Policy to allow Roles to be assumed by Kube2Iam"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/k8s-*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "worker_node_kube2iam" {
  count = "${var.supports_kube2iam ? 1 : 0}"

  policy_arn = "${aws_iam_policy.eks_worker_kube2iam.arn}"
  role       = "${aws_iam_role.worker_node.name}"
}
