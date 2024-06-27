resource "terraform_data" "update_kubeconfig" {
  provisioner "local-exec" {
    command = <<-EOT
       aws eks --region ${var.aws_region_name} update-kubeconfig --name ${var.cluster_name}
    EOT
    interpreter = ["bash", "-c"]
  }
  depends_on = [aws_eks_cluster.cluster]
}