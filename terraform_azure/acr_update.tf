resource "terraform_data" "update_aks" {
  provisioner "local-exec" {
    command = <<-EOT
       az aks update --resource-group ${var.resource_group_name} --name ${var.cluster_name} --attach-acr ${var.acrName}
    EOT
    interpreter = ["bash", "-c"]
  }
  depends_on = [azurerm_kubernetes_cluster.main]
}