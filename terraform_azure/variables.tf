variable "azure_region_name" {
  type        = string
  description = "Region"
  default     = "germanywestcentral"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
  default     = "azure-demo-rg"
}

/*
variable "acrName" {
  type        = string
  description = "acrName"
  default    = "vehcal"
}

variable "acrResourceGroupName" {
  type        = string
  description = "acrResourceGroupName"
  default    = "azure-containers-rg"
}
*/

variable "cluster_name" {
  type        = string
  description = "Cluster name"
  default     = "demo"
}

variable "subnet_names" {
  type        = list(string)
  description = "Subnet Names"
  default     = ["subnet1", "subnet2"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
  default     = ["10.0.80.0/24", "10.0.81.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "acr_name" {
  type        = string
  description = "azure container resource name to provide access for acr"
  default     = "Vehcal"
}

variable "acr_group" {
  type        = string
  description = "azure container resource group name to provide access for acr"
  default     = "azure-containers-rg"
}

variable "acr_id" {
  type        = string
  description = "azure container resource id to provide access for aks"
  default     = "1edd3415-0da7-48ac-bf82-90655f47a8a1"
}
