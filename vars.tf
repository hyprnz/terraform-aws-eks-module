variable "cluster_name" {
  description = "The EKS cluster name"
}

variable "vpc_id" {}

variable "eks_vpc_enable_endpoint_private_access" {
  description = "Enable EKS cluster endpoint from within the VPC"
  default     = true
}

variable "eks_vpc_enable_endpoint_public_access" {
  description = "Enable EKS cluster endpoint from the internet"
  default     = false
}

variable "eks_master_subnet_ids" {
  description = "Subnet ids for the EKS Master Cluster"
  default     = []
}

variable "eks_worker_subnet_ids" {
  description = "Subnet ids for the EKS worker nodes"
  default     = []
}

variable "worker_node_instance_type" {
  description = "Instance type used for EKS worker Nodes"
}

variable "worker_asg_desired_count" {
  description = "Desired number of nodes for worker asg"
}

variable "worker_asg_max_size" {
  description = "Maximun number of nodes for worker asg"
}

variable "worker_asg_min_size" {
  description = "Minimum number of nodes for worker asg"
  default     = 1
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

variable "maproles_team_role_arn" {
  description = "The arn of the IAM role that maps to a Kubernetes role"
}

variable "maproles_username" {
  description = "The user name of the product teams for the maprole config"
  default     = "kubectl-user-access"
}
