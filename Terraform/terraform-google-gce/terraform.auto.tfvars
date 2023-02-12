list_of_vms = [
  {
    project_id                = "learn-gcpdevops",
    hostname                  = "adarshasuvarna.in",
    instance_name             = "devops-project-1",
    machine_type              = "n1-standard-1",
    tags                      = ["ssh", "http", "https", "devops"],
    allow_stopping_for_update = true,
    labels = {
      "env" : "uat"
    },
    can_ip_forward = false,
    network_interface = [
      {
        nic_subnetwork         = "default",
        nic_subnetwork_project = "learn-gcpdevops",
        nic_subnetwork_region  = "us-central1",
        nic_access_config = [{
          nic_nat_ip       = ""
          nic_network_tier = "STANDARD"
        }]
      },
    ]
    source_image         = "centos-7-v20230203",
    source_image_family  = "centos-7",
    source_image_project = "centos-cloud",
    auto_delete          = true,
    boot_disk_type       = "pd-standard",
    disk_labels          = "adarsh",
    boot_size            = 30,
    zone                 = "us-central1-a",
    svc_account_id       = "devops-project-1@learn-gcpdevops.iam.gserviceaccount.com",
    additional_disks     = []
  }
]
