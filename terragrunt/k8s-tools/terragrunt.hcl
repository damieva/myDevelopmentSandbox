include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  # Apunta a la carpeta donde definiste ArgoCD e Ingress
  source = "../../modules/k8s-tools"
}

# ESTA ES LA CLAVE: Lee los outputs del otro estado (workspace)
dependency "cluster" {
  config_path = "../k8s-cluster"
}

# Mapeamos los outputs del cluster a los inputs que necesita el provider de Helm
inputs = {
  cluster_endpoint = dependency.cluster.outputs.endpoint
  cluster_ca       = dependency.cluster.outputs.cluster_ca
  cluster_cert     = dependency.cluster.outputs.client_cert
  cluster_key      = dependency.cluster.outputs.client_key
}