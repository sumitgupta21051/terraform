variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string  
  
}
variable "location" {
  description = "The Azure region where the Key Vault will be created."
  type        = string
  default     = "canadacentral"
    
}
variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created."
  type        = string
  default     = "todo-sumit"
  
}

variable "secret_name" {
  description = "The name of the secret to be stored in the Key Vault."
  type        = string
  
  
}
variable "secret_value" {
  description = "The value of the secret to be stored in the Key Vault."
  type        = string
  default     = "Mnbv@12345678"
  
}
