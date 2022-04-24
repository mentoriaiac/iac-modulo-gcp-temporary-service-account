variable "project_id" {
  type    = string
  default = ""
}

provider "google" {
  project = var.project_id
}

module "tmp_packer_key" {
  source = "../"

  project_id              = var.project_id
  preset_roles            = ["packer"]
  service_account_id      = "packer"
  duration                = "10m"
  reset_duration_on_apply = false
  key_file                = "${path.module}/.keys/packer.json"
}
