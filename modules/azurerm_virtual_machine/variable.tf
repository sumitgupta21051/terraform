variable "nic_name" {
  description = "The name of the public IP address"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  
}
variable "location" {
  description = "The Azure region where the public IP will be created"
  type        = string
  
}
variable "pip_name" {
  description = "The name of the public IP address"
  type        = string
  
}

variable "vmname" {
  description = "The name of the virtual machine"
  type        = string
  
}
variable "size" {
  description = "The size of the virtual machine"
  type        = string
    
}


variable "publisher" {
  description = "The publisher of the image to use for the virtual machine"
  type        = string
  
}
variable "offer" {
  description = "The offer of the image to use for the virtual machine"
  type        = string
  
}
variable "planid" {
  description = "The plan ID of the image to use for the virtual machine"
  type        = string
  
}
variable "image_version" {
  description = "The version of the image to use for the virtual machine"
  type        = string
  
} 

variable "subnet_name" {
  description = "The name of the subnet within the virtual network"
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network where the subnet is located"
  type        = string
  
}