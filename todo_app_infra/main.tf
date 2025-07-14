module "resource_group" {
  source = "../modules/azurerm_resource_group"
  resource_group_name = "todo-sumit"
  resource_group_location = "canadacentral"
}
module "virtual_network" {
    depends_on = [ module.resource_group ]
    source = "../modules/azurerm_vnet"
    virtual_network_name = "todo-sumit-vnet"
    virtual_network_location = "canadacentral"
    resource_group_name = "todo-sumit"
    address_space = ["10.0.0.0/16"]
  
}
module "frontend_subnet" {
    depends_on = [ module.virtual_network ]
  source = "../modules/azurerm_subnet"
  subnet_name = "todo-sumit-frontendsubnet"
  address_prefixes = ["10.0.1.0/24"]
  resource_group_name = "todo-sumit"
  virtual_network_name = "todo-sumit-vnet"
  
}
module "backend_subnet" {
    depends_on = [ module.virtual_network ]
  source = "../modules/azurerm_subnet"
  subnet_name = "todo-sumit-backendsubnet"
  address_prefixes = ["10.0.2.0/24"]
  resource_group_name = "todo-sumit"
  virtual_network_name = "todo-sumit-vnet"
  
}
module "public_ip_frontend" {
  source = "../modules/azurerm_public_ip"
  public_ip = "front-pip1"   
    resource_group_name = "todo-sumit"
    location = "canadacentral"
    allocation_method = "Static"

}
module "public_ip_backend" {
  source = "../modules/azurerm_public_ip"
  public_ip = "backend-pip"   
    resource_group_name = "todo-sumit"
    location = "canadacentral"
    allocation_method = "Static"
    
}
module "frontend-vmname" {
    depends_on = [ module.frontend_subnet, module.public_ip_frontend ]
  source = "../modules/azurerm_virtual_machine"
  vmname = "frontend-vm"
  resource_group_name = "todo-sumit"
  location = "canadacentral"
  size = "Standard_B1s"
    nic_name = "frontend-nic"
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-jammy"
  planid = "22_04-lts"
  image_version = "latest"
  virtual_network_name = "todo-sumit-vnet"
  subnet_name = "todo-sumit-frontendsubnet"
  pip_name = "front-pip1"

}
module "backend-vmname" {
    depends_on = [ module.backend_subnet, module.public_ip_backend ]
  source = "../modules/azurerm_virtual_machine"
  vmname = "backend-vm"
  resource_group_name = "todo-sumit"
  location = "canadacentral"
  size = "Standard_B1s"
  nic_name = "backend-nic"
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-focal"
  planid = "20_04-lts"
  image_version = "latest"
  virtual_network_name = "todo-sumit-vnet"
  subnet_name = "todo-sumit-backendsubnet"  
  pip_name = "backend-pip"

}
module "sql_server" {
  source = "../modules/azurerm_sql_server"
  sql_server_name = "todo-sumit-sqlserver"
  resource_group_name = "todo-sumit"
  location = "canadacentral"
  administrator_login = "sumit"
  administrator_login_password = "Mnbv@12345678"
  
}
module "sql_database" { 
    depends_on = [ module.sql_server ]
  source = "../modules/azurerm_sql_database"
  sql_database = "todo-sumit-db"
  server_id = "/subscriptions/c031aa3a-a601-4446-882c-da628da25346/resourceGroups/todo-sumit/providers/Microsoft.Sql/servers/todo-sumit-sqlserver"
  
}   

# module "key_vault" {
#   source = "../modules/azurerm_key_vault"
#   key_vault_name = "todo-sumit-kv"
#   location = "canadacentral"
#   resource_group_name = "todo-sumit"
# }