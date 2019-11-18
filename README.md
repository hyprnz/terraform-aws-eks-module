# Terraform EKS Module
This module provisions an EKS control plane and a Worker nodes ASG. Adds the `aws-auth` ConfigMap from the Terraform Kubernetes Provider, allowing worker nodes to join the control plane without the need for a separate `kubectl` command. Designed to share an existing and provisioned VPC.

The cluster_config output can be used to provide the kubectl connection configuration parameters.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | The EKS cluster name | string | n/a | yes |
| k8s\_version | The K8s version to use on the cluster | string | n/a | yes |
| maproles\_team\_role\_arn | The arn of the IAM role that maps to a Kubernetes role | string | n/a | yes |
| vpc\_id | The vpc_id that the cluster will bind to | string | n/a | yes |
| worker\_asg\_desired\_count | Desired number of nodes for worker asg | string | n/a | yes |
| worker\_asg\_max\_size | Maximum number of nodes for worker asg | string | n/a | yes |
| worker\_node\_instance\_type | Instance type used for EKS worker Nodes | string | n/a | yes |
| eks\_master\_subnet\_ids | Subnet ids for the EKS Master Cluster | list | `<list>` | no |
| eks\_vpc\_enable\_endpoint\_private\_access | Enable EKS cluster endpoint from within the VPC | string | `"true"` | no |
| eks\_vpc\_enable\_endpoint\_public\_access | Enable EKS cluster endpoint from the internet | string | `"false"` | no |
| eks\_worker\_subnet\_ids | Subnet ids for the EKS worker nodes | list | `<list>` | no |
| maproles\_username | The user name of the product teams for the maprole config | string | `"kubectl-user-access"` | no |
| supports\_kube2iam | A flag to control if an additional IAM policy to assume roles for Kube2Iam is added to worker node role | string | `"false"` | no |
| worker\_asg\_min\_size | Minimum number of nodes for worker asg | string | `"1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_config | Kube config file of the current cluster |
| cluster\_endpoint | EKS control plane endpoint |
| cluster\_name | Name of the EKS Cluster |
| platform\_version | EKS platform version |
| version | EKS Kubernetes version |

