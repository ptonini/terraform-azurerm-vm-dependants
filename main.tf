resource "azurerm_virtual_machine_extension" "this" {
  for_each                   = var.extensions
  virtual_machine_id         = var.virtual_machine_id
  name                       = each.key
  publisher                  = each.value.publisher
  type                       = each.value.type
  auto_upgrade_minor_version = each.value.auto_upgrade_minor_version
  type_handler_version       = each.value.type_handler_version
  settings                   = each.value.settings
  protected_settings         = each.value.protected_settings

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"]
    ]
  }
}

module "managed_disks" {
  source                         = "ptonini/managed-disk/azurerm"
  version                        = "~> 1.0.2"
  for_each                       = var.extra_disks
  rg                             = var.rg
  virtual_machine_id             = var.virtual_machine_id
  name                           = each.key
  storage_account_type           = each.value.storage_account_type
  disk_size_gb                   = each.value.disk_size_gb
  virtual_machine_attachment_lun = each.value.virtual_machine_attachment_lun
}