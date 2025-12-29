include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  # Apunta a la carpeta donde definiste el recurso "kind_cluster"
  source = "../../modules/k8s-cluster"
}

inputs = {
  cluster_name = "my-development-sandbox"
}