variable "hostname" {
  description = "Hostname prefix for instances."
  default     = "default"
}

variable "region" {
  description = "The GCP region where instances will be deployed."
  type        = string
  default     = "asia-south1"
}

variable "project_id" {
  description = "The GCP project to use for integration tests"
  type        = string
}

variable "nic0_network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  default     = ""
}

variable "nic0_network_ip" {
  description = "Private IP address to assign to the instance if desired."
  default     = ""
}

variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  default     = "n1-standard-1"
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

/* disk */
variable "source_image" {
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = ""
}

variable "source_image_family" {
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = ""
}

variable "source_image_project" {
  description = "Project where the source image comes from"
  default     = ""
}

variable "zone" {
  type        = string
  description = "zone"
  default     = "asia-south1-a"
}

variable "boot_disk_type" {
  description = "Disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-ssd"
}

variable "boot_size" {
  type        = string
  description = "boot_size"
}

variable "auto_delete" {
  description = "Whether or not the disk should be auto-deleted"
  default     = "true"
}

variable "nic0" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nic0_network            = string
    nic0_subnetwork         = string
    nic0_subnetwork_project = string
  }))
  default = []
}

variable "nic0_access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nic0_nat_ip       = string
    nic0_network_tier = string
  }))
  default = []
}

variable "sa_email" {
  type        = string
  description = "zone"
  default     = " "
}

variable "instance_name" {
  type        = string
  description = "zone"
  default     = " "
}

variable "additional_disks" {
  description = "List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name"
  type = list(object({
    disk_name    = string
    device_name  = string
    auto_delete  = bool
    boot         = bool
    mode         = string
    disk_size_gb = number
    disk_type    = string
    disk_labels  = map(string)
  }))
  default = []
}

variable "kms_key_self_link" {
  type        = string
  description = "disk_encryption_key"
  default     = " "
}

variable "svc_account_id" {
  type        = string
  description = "svc_account_id"
}

variable "can_ip_forward" {
  type        = string
  description = "can_ip_forward"
}

variable "network_interface" {
  type = list(object({
    nic_subnetwork         = string
    nic_subnetwork_project = string
    nic_subnetwork_region  = string
    nic_access_config = list(object({
      nic_nat_ip       = string
      nic_network_tier = string
    }))
  }))
}

variable "allow_stopping_for_update" {
  type        = bool
  description = "allow_stopping_for_update"
}