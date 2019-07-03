variable "cluster_name" {
  description = "The EKS cluster name"
}
variable "vpc_id" {
}

variable "eks_master_subnet_ids" {
  description = "Subnet ids for the EKS Master Cluster"
  default = []
}


variable "allowed_client_mgmt_addresses" {
  description = "Public IP addresses allowed to connect to EKS master"
  default     = []
}

variable "k8s_version" {
  description = "The K8s version to use on the cluster"
}


