resource "terraform_data" "update_kubeconfig" {
  provisioner "local-exec" {
    command = <<-EOT
       az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.cluster_name} --overwrite-existing
    EOT
    interpreter = ["bash", "-c"]
  }
  depends_on = [azurerm_kubernetes_cluster.main]
}