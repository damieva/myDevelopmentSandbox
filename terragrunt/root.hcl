generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "remote" {
    organization = "my-development-sandbox"

    workspaces {
      name = "${path_relative_to_include()}"
    }
  }
}
EOF
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.5.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}
provider "kind" {}
provider "helm" {
  kubernetes {
    # Estas variables serán inyectadas por los módulos hijos
    host                   = var.cluster_endpoint
    client_certificate     = var.cluster_cert
    client_key             = var.cluster_key
    cluster_ca_certificate = var.cluster_ca
  }
}

# Declaramos las variables para que el provider de Helm no de error
variable "cluster_endpoint" {
  type    = string
  default = ""
}

variable "cluster_ca" {
  type    = string
  default = ""
}

variable "cluster_cert" {
  type    = string
  default = ""
}

variable "cluster_key" {
  type    = string
  default = ""
}
EOF
}