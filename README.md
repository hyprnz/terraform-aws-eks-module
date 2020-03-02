# Terraform AWS EKS Module
This module provisions an EKS control plane and a Worker node ASG. Adds the `aws-auth` ConfigMap from the Terraform Kubernetes Provider, allowing worker nodes to automatically join the control plane without the need for a separate `kubectl` command. The module is dependent on a configured VPC.

It takes about ~10 mins for a control plane to converge.

## Kubernetes Provider 1.11
This module does not work with the Kubernetes provider version 1.11 and has been pinned to version 1.10. A change has been made that now impacts the current design.

## AWS SSM Session Manager
The EKS worker nodes are configure by default to support Session Manager connections. This provides shell access to an EKS worker node, without the need for a bastion host and a key rotation/management policy. Access to Session Manager can be managed by IAM roles & Policies and provides a full history of connected sessions. More information on how to start a session can be found here - https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-sessions-start.html

## EKS Control Plane Logging
EKs control plane logging is set to persist logs to the `/aws/eks/${var.cluster_name/cluster}` log group.

## EKS Node Instance Logging
EKS worker nodes now log ship the following instance logs to the CloudWatch log group `/aws/eks/${var.cluster_name}/node_logs`

* `/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log` to the `cloudwatch-agent-{instance_id}` stream.

* `/var/log/cloud-init-output.log` to the `cloud-init-output-{instance_id}` stream.

* `/var/log/messages"` to the `syslog-{instance_id}` stream.

The variable `cloudwatch_log_retention` controls how long logs are stored for all log groups.

## Kube2Iam Support
This module provides optional support for the `Kube2Iam` pattern. The setting will create the IAM roles and policies to allow the worker node role to assume the role requires for a specific Kubernetes service.

All service roles must be prefixed with `k8s-` in order to assume the role.

At this stage, this module does not apply the Kube2Iam manifest. This is currently out of scope for this module.

More information on Kube2Iam can be found here - https://github.com/jtblin/kube2iam

## Example
An example has been provided at examples/default. This example can be used to understand how to implement this module.

---

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.19 |
| kubernetes | 1.10 |
| template | ~> 2.1.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_name | The EKS cluster name | `any` | n/a | yes |
| k8s\_version | The K8s version to use on the cluster | `any` | n/a | yes |
| maproles\_team\_role\_arn | The arn of the IAM role that maps to a Kubernetes role | `any` | n/a | yes |
| vpc\_id | The vpc\_id that the cluster will bind to | `any` | n/a | yes |
| worker\_asg\_desired\_count | Desired number of nodes for worker asg | `any` | n/a | yes |
| worker\_asg\_max\_size | Maximum number of nodes for worker asg | `any` | n/a | yes |
| worker\_node\_instance\_type | Instance type used for EKS worker Nodes | `any` | n/a | yes |
| cloudwatch\_log\_retention | The retention period in days for all CloudWatch Log Group. Defaults to `7 days` | `number` | `7` | no |
| eks\_master\_subnet\_ids | Subnet ids for the EKS Master Cluster | `list` | `[]` | no |
| eks\_vpc\_enable\_endpoint\_private\_access | Enable EKS cluster endpoint from within the VPC | `bool` | `true` | no |
| eks\_vpc\_enable\_endpoint\_public\_access | Enable EKS cluster endpoint from the internet | `bool` | `false` | no |
| eks\_worker\_subnet\_ids | Subnet ids for the EKS worker nodes | `list` | `[]` | no |
| maproles\_username | The user name of the product teams for the maprole config | `string` | `"kubectl-user-access"` | no |
| ssh\_key\_name | The key pair to use for ssh connections | `string` | `""` | no |
| supports\_kube2iam | A flag to control if an additional IAM policy to assume roles for Kube2Iam is added to worker node role | `bool` | `false` | no |
| worker\_asg\_min\_size | Minimum number of nodes for worker asg | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_config | Kube config file of the current cluster |
| cluster\_endpoint | EKS control plane endpoint |
| cluster\_name | Name of the EKS Cluster |
| platform\_version | EKS platform version |
| version | EKS Kubernetes version |

