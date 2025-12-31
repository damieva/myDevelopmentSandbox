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
      # En kind, los nodos del cluster son contenedores Docker. El proceso de kind
      # expone puertos del host (8080 y 4443) y los redirige a los puertos 80 y 443
      # del contenedor que actúa como control-plane.
      #
      # De esta forma, todo el tráfico que llega a:
      #   - http://localhost:8080
      #   - https://localhost:4443
      # entra en el cluster a través del control-plane node.
      #
      # Para que ingress-nginx pueda recibir ese tráfico, se despliega usando hostPort,
      # de modo que kubelet configura reglas de red que redirigen el tráfico que llega
      # a los puertos 80 y 443 del nodo hacia el pod del ingress controller.
      #
      # Esto permite que el tráfico que entra desde el host sea entregado directamente
      # al pod de ingress-nginx sin necesidad de usar hostNetwork, manteniendo un mayor
      # aislamiento de red.
      #
      # En entornos cloud, este rol lo cumple un LoadBalancer externo, que expone un
      # endpoint público y envía el tráfico a los nodos del cluster mediante un Service
      # de tipo LoadBalancer.
      #
      # Flujo completo:
      #   http://localhost:8080
      #   → proceso de kind (Docker port mapping)
      #   → control-plane container:80
      #   → kernel del nodo
      #   → reglas NAT configuradas por kubelet (hostPort)
      #   → ingress-nginx pod:80
      #   → nginx
      #
      # En el setup actual (kind + ingress con hostPort), el Service NodePort NO se usa
      # para la entrada de tráfico. Su valor es principalmente de coherencia y realismo
      # respecto a entornos de producción.
      extra_port_mappings {
        container_port = 80
        host_port      = 8080
        protocol       = "TCP"
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 4443
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
