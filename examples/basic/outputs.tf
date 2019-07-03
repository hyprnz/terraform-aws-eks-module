output "cluster_endpoint" {
  value = "${module.example.cluster_endpoint}"
}

output "certificate_authority" {
  value = "${module.example.certificate_authority}"
}

output "platform_version" {
  value = "${module.example.platform_version}"
}

output "version" {
  value = "${module.example.version}"
}
output "kubeconfig" {
  value = "${module.example.kubeconfig}"
}