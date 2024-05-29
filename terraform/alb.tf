provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
//aws eks --region eu-central-1 update-kubeconfig --name demo

/*
resource "helm_release" "ingress" {
  name       = "ingress"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = "1.4.6"

  set {
    name  = "autoDiscoverAwsRegion"
    value = "true"
  }
  set {
    name  = "autoDiscoverAwsVpcID"
    value = "true"
  }
  set {
    name  = "clusterName"
    value = aws_eks_cluster.cluster.id
  }
  depends_on = [aws_eks_fargate_profile.kube-system]
}
*/

resource "helm_release" "aws-load-balancer-controller" {
  name = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.4.1"
  set {
    name  = "clusterName"
    value = aws_eks_cluster.cluster.id
  }
  set {
    name  = "image.tag"
    value = "v2.4.2"
  }
  set {
    name  = "replicaCount"
    value = 1
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }
  set {
    name  = "region"
    value = "eu-central-1"
  }
  set {
    name  = "vpcId"
    value = aws_vpc.main.id
  }
  depends_on = [aws_eks_fargate_profile.kube-system]
}

//aws eks update-kubeconfig --name demo --region eu-central-1