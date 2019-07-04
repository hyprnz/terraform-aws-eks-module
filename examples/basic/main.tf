terraform {
  backend "local" {}
}

module "example" {
  source = "../../"

  cluster_name            = "eks_uat_jarden_co_nz"
  k8s_version           = 1.13
  allowed_client_mgmt_addresses = ["103.45.241.29/32"]
  vpc_id                = "vpc-03c23c31c01c96069"
  eks_master_subnet_ids = ["subnet-0a3d915e9ae4ba461","subnet-085f3e2e095bdfdcd","subnet-0b73adae6b824bfd6"]
  eks_worker_subnet_ids = ["subnet-087064c8837c0a0bf", "subnet-012ce197d0f472f4e","subnet-0717aa5f3d011eef7"]
}