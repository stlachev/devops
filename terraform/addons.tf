resource "aws_eks_addon" "Coredns" {
  cluster_name                = var.cluster_name
  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.11"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = 2
  })
  depends_on = [aws_eks_fargate_profile.kube-system]
}

resource "aws_eks_addon" "KubeProxy" {
  cluster_name                = var.cluster_name
  addon_name                  = "kube-proxy"
  depends_on = [aws_eks_fargate_profile.kube-system]
}

resource "aws_eks_addon" "VpcCni" {
  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
  depends_on = [aws_eks_fargate_profile.kube-system]
}

resource "aws_eks_addon" "EksPodIdentityAgent" {
  cluster_name                = var.cluster_name
  addon_name                  = "eks-pod-identity-agent"
  depends_on = [aws_eks_fargate_profile.kube-system]
}
