resource "aws_security_group" "cluster_node" {
  name        = "${var.cluster_name}"
  description = "Cluster communication with workers nodes"
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

