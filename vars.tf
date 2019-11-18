variable "cluster_name" {
  description = "The EKS cluster name"
}

variable "vpc_id" {
  description = "The vpc_id that the cluster will bind to"
}

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
  description = "Maximum number of nodes for worker asg"
}

variable "worker_asg_min_size" {
  description = "Minimum number of nodes for worker asg"
  default     = 1
}

variable "k8s_version" {
  description = "The K8s version to use on the cluster"
}

variable "maproles_team_role_arn" {
  description = "The arn of the IAM role that maps to a Kubernetes role"
}

variable "maproles_username" {
  description = "The user name of the product teams for the maprole config"
  default     = "kubectl-user-access"
}

variable "supports_kube2iam" {
  description = "A flag to control if an addaitional IAM poliy to assume roles for Kube2Iam is added to worker node role"
  default     = false
}
