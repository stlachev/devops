resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  namespace        = "kube-system"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"

  values = [
    file("ingress-nginx-values.yaml")
  ]
  depends_on = [azurerm_kubernetes_cluster.main]
}