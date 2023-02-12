variable "list_of_vms" {
  description = ""
  type = list(object({
    project_id                = string
    hostname                  = string
    machine_type              = string
    tags                      = list(string)
    labels                    = map(string)
    can_ip_forward            = bool
    source_image              = string
    source_image_family       = string
    source_image_project      = string
    auto_delete               = string
    boot_disk_type            = string
    disk_labels               = string
    boot_size                 = number
    zone                      = string
    instance_name             = string
    allow_stopping_for_update = bool
    network_interface = list(object({
      nic_subnetwork         = string
      nic_subnetwork_project = string
      nic_subnetwork_region  = string
      nic_access_config = list(object({
        nic_nat_ip       = string
        nic_network_tier = string

      }))
    }))
    svc_account_id = string
    additional_disks = list(object({
      disk_name    = string
      device_name  = string
      auto_delete  = bool
      boot         = bool
      mode         = string
      disk_size_gb = number
      disk_type    = string
      disk_labels  = map(string)
    }))
  }))
  default = []
}
