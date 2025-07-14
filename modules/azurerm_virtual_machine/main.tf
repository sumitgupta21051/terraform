data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "sumitvault"
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "vm-user" {
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "vm-pass" {
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pip.id
  }
}



resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vmname
  resource_group_name = var.resource_group_name
    location            = var.location
  size                = var.size
  admin_username      = data.azurerm_key_vault_secret.vm-user.value
  admin_password = data.azurerm_key_vault_secret.vm-pass.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer 
     sku       = var.planid
    version   = var.image_version
  }
 
  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
)

}

