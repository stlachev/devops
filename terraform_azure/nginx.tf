/*
resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "3.23.0"
//  namespace  = kubernetes_namespace.ingress-nginx.metadata.0.name

  values = [
    file("ingress-nginx-values.yaml")
  ]
}
*/
resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  namespace        = "kube-system"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"

  values = [
    file("ingress-nginx-values.yaml")
  ]
}