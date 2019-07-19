terraform {
  backend "local" {}
}

data "aws_subnet_ids" "private" {
  vpc_id = "${var.vpc_id}"

  tags {
    Tier = "Private"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${var.vpc_id}"

  tags {
    Tier = "Public"
  }
}

module "example" {
  source = "../../"

  cluster_name                            = "eks-env-example"
  k8s_version                             = 1.13
  vpc_id                                  = "${var.vpc_id}"
  eks_master_subnet_ids                   = "${concat(data.aws_subnet_ids.public.ids, data.aws_subnet_ids.private.ids)}"
  eks_worker_subnet_ids                   = "${data.aws_subnet_ids.private.ids}"
  eks_vpc_enable_endpoint_public_access   = true
  worker_node_instance_type               = "t3.small"
  worker_asg_desired_count                = 3
  worker_asg_max_size                     = 3
}

variable "vpc_id" {
  description = "The id of the vpc used for EKS"
  default = ""
}
