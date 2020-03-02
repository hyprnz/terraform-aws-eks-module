resource "aws_cloudwatch_log_group" "this" {
  name              = "${local.cluster_log_group}"
  retention_in_days = "${var.cloudwatch_log_retention}"
}

resource "aws_cloudwatch_log_group" "k8_worker_node" {
  name              = "${local.worker_node_log_group}"
  retention_in_days = "${var.cloudwatch_log_retention}"
}
