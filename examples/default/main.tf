module "example" {
  source = "../../"

  providers = {
    aws = aws
  }

  cluster_name                          = "eks-stage-example"
  k8s_version                           = 1.13
  vpc_id                                = aws_vpc.test_vpc.id
  eks_master_subnet_ids                 = [aws_subnet.private1.id, aws_subnet.private2.id, aws_subnet.private3.id, aws_subnet.public1.id, aws_subnet.public2.id, aws_subnet.public3.id]
  eks_worker_subnet_ids                 = [aws_subnet.private1.id, aws_subnet.private2.id, aws_subnet.private3.id]
  eks_vpc_enable_endpoint_public_access = true
  worker_node_instance_type             = "t3.small"
  worker_asg_desired_count              = 1
  worker_asg_max_size                   = 1

  maproles_team_role_arn = ""
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "ap-southeast-2"
}