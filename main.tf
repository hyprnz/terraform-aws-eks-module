##
# EKS Control Plane
##
resource "aws_eks_cluster" "this" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.cluster_node.arn}"
  version  = "${var.k8s_version}"

  vpc_config {
    security_group_ids      = ["${aws_security_group.cluster_node.id}"]
    subnet_ids              = ["${var.eks_master_subnet_ids}"]
    endpoint_private_access = "${var.eks_vpc_enable_endpoint_private_access}"
    endpoint_public_access  = "${var.eks_vpc_enable_endpoint_public_access}"
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    "aws_iam_role_policy_attachment.amazon_eks_cluster_policy",
    "aws_iam_role_policy_attachment.amazon_eks_service_policy",
    "aws_cloudwatch_log_group.this",
  ]
}

##
# Worker node launch configuration
##
resource "aws_launch_configuration" "worker_node" {
  iam_instance_profile = "${aws_iam_instance_profile.eks_worker_node.name}"
  image_id             = "${data.aws_ami.eks_worker.id}"
  instance_type        = "${var.worker_node_instance_type}"
  name_prefix          = "${var.cluster_name}"
  security_groups      = ["${aws_security_group.worker_node.id}"]
  user_data_base64     = "${base64encode(local.worker_node_userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

##
# Worker node asg
##

resource "aws_autoscaling_group" "worker_node" {
  desired_capacity     = "${var.worker_asg_desired_count}"
  launch_configuration = "${aws_launch_configuration.worker_node.id}"
  max_size             = "${var.worker_asg_max_size}"
  min_size             = "${var.worker_asg_min_size}"
  name                 = "${var.cluster_name}-worker-node"
  vpc_zone_identifier  = ["${var.eks_worker_subnet_ids}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-worker-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
