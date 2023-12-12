variable "rg" {}

variable "virtual_machine_id" {}

variable "extra_disks" {
  type = map(object({
    storage_account_type = string
    disk_size_gb         = string
    virtual_machine_attachment_lun = number
  }))
  default = {}
}

variable "extensions" {
  type = map(object({
    publisher                  = string
    type                       = string
    auto_upgrade_minor_version = optional(bool, true)
    type_handler_version       = string
    settings                   = optional(string)
    protected_settings         = optional(string)
  }))
  default = {}
}