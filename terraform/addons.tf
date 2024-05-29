resource "aws_eks_addon" "Coredns" {
  cluster_name                = var.cluster_name
  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.11"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = 2
 /*   resources = {
      limits = {
        cpu    = "10m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "10m"
        memory = "50Mi"
      }
    }*/
  })
  depends_on = [aws_eks_fargate_profile.kube-system]
}

resource "aws_eks_addon" "KubeProxy" {
  cluster_name                = var.cluster_name
  addon_name                  = "kube-proxy"
//  addon_version               = "v1.29.0-eksbuild.1"
//  resolve_conflicts_on_create = "OVERWRITE"
  depends_on = [aws_eks_fargate_profile.kube-system]
}

resource "aws_eks_addon" "VpcCni" {
  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
//  addon_version               = "v1.16.0-eksbuild.1"
//  resolve_conflicts_on_create = "OVERWRITE"
  depends_on = [aws_eks_fargate_profile.kube-system]
}

resource "aws_eks_addon" "EksPodIdentityAgent" {
  cluster_name                = var.cluster_name
  addon_name                  = "eks-pod-identity-agent"
//  addon_version               = "v1.2.0-eksbuild.1"
//  resolve_conflicts_on_create = "OVERWRITE"
  depends_on = [aws_eks_fargate_profile.kube-system]
}
