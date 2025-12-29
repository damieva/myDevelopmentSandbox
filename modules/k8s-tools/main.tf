# Instalación de ArgoCD
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.52.0"
}

# Instalación de NGINX Ingress Controller
#resource "helm_release" "ingress_nginx" {
#  name             = "ingress-nginx"
#  repository       = "https://kubernetes.github.io/ingress-nginx"
#  chart            = "ingress-nginx"
#  namespace        = "ingress-nginx"
#  create_namespace = true
#  version          = "4.9.0"
#
#  # Configuración específica para compatibilidad con Kind
#  set {
#    name  = "controller.service.type"
#    value = "NodePort"
#  }
#  set {
#    name  = "controller.hostPort.enabled"
#    value = "true"
#  }
#  set {
#    name  = "controller.nodeSelector.ingress-ready"
#    value = "true"
#  }
#  set {
#    name  = "controller.admissionWebhooks.enabled"
#    value = "false"
#  }
#}
