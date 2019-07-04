##
# Cluster nodes
##
resource "aws_security_group" "cluster_node" {
  name        = "${var.cluster_name}_cluster_node"
  description = "Cluster communication"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}"
  }
}

resource "aws_security_group_rule" "cluster_mgmt_ingress_allow" {
  cidr_blocks       = "${var.allowed_client_mgmt_addresses}"
  description       = "Allow client management to cluster API server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cluster_node.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_worker_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.cluster_node.id}"
  source_security_group_id = "${aws_security_group.worker_node.id}"
  to_port                  = 443
  type                     = "ingress"
}

##
# Worker nodes
##

resource "aws_security_group" "worker_node" {
  name        = "${var.cluster_name}_worker_node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "${var.cluster_name}",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "worker_node_ingress_self" {
  description              = "Allow worker nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.worker_node.id}"
  source_security_group_id = "${aws_security_group.worker_node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_node_ingress_cluster" {
  description              = "Allow worker node Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.worker_node.id}"
  source_security_group_id = "${aws_security_group.cluster_node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

