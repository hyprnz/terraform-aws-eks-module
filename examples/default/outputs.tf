output "cluster_endpoint" {
  value = "${module.example.cluster_endpoint}"
}

output "cluster_config" {
  value     = "${module.example.cluster_config}"
  sensitive = true
}

output "platform_version" {
  value = "${module.example.platform_version}"
}

output "version" {
  value = "${module.example.version}"
}
