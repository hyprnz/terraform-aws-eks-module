variable "cluster_name" {
  description = "The EKS cluster name"
}
variable "vpc_id" {
}

variable "eks_master_subnet_ids" {
  description = "Subnet ids for the EKS Master Cluster"
  default = []
}

variable "eks_worker_subnet_ids" {
  description = "Subnet ids for the EKS worker nodes"
  default = []
}

variable "k8s_version" {
  description = "The K8s version to use on the cluster"
}

variable "kubconfig_write_path" {
  description = "path to write kubeconfig file"
  default     = "./"
}

variable "certificate_authority_write_path" {
  description = "path to write the control plane certificate"
  default     = "./"
}

