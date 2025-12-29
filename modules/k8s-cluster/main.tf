resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
      #image = "kindest/node:v1.22.17@sha256:f5b2e5698c6c9d6d0adc419c0deae21a425c07d81bbf3b6a6834042f25d4fba2"
      # Mapeo necesario para que el tráfico llegue al Ingress Controller
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]
      extra_port_mappings {
        container_port = 80
        host_port      = 80
        protocol       = "TCP"
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
        protocol       = "TCP"
      }
      #      extra_mounts {
      #        container_path = "/var/lib/kubelet/config.json"
      #        host_path      = "/home/denisamieva/.docker/config.json"
      #      }
    }
    node {
      role = "worker"
      #image = "kindest/node:v1.22.17@sha256:f5b2e5698c6c9d6d0adc419c0deae21a425c07d81bbf3b6a6834042f25d4fba2"
      #      extra_mounts {
      #        container_path = "/var/lib/kubelet/config.json"
      #        host_path      = "/home/denisamieva/.docker/config.json"
      #      }
    }
  }
}
