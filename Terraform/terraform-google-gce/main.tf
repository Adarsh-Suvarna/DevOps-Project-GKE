module "compute_instance" {
  for_each                  = { for x in var.list_of_vms : x.instance_name => x }
  source                    = "./modules/compute_instance"
  project_id                = each.value.project_id
  zone                      = each.value.zone
  source_image              = each.value.source_image
  source_image_family       = each.value.source_image_family
  source_image_project      = each.value.source_image_project
  machine_type              = each.value.machine_type
  hostname                  = each.value.hostname
  boot_disk_type            = each.value.boot_disk_type
  boot_size                 = each.value.boot_size
  tags                      = each.value.tags
  svc_account_id            = each.value.svc_account_id
  instance_name             = each.value.instance_name
  network_interface         = each.value.network_interface
  labels                    = each.value.labels
  can_ip_forward            = each.value.can_ip_forward
  additional_disks          = each.value.additional_disks
  allow_stopping_for_update = each.value.allow_stopping_for_update
}