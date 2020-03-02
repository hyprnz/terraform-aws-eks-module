
terraform {
  required_version = "> 0.12.0, < 0.13.0"
  required_providers {
    aws        = "~> 2.19"
    kubernetes = "1.10"
    template   = "~> 2.1.2"

  }
}
