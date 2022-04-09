locals {
  # presets são configurações padrões de roles que são comumente utilizadas
  # para utilizar uma ferramenta, ou realizar uma tarefa.
  # Ao adicionar ou remover um preset, lembre de também atualizar a variável.
  # preset_roles.
  presets = {
    "packer" : [
      "compute.instanceAdmin.v1",
      "iam.serviceAccountUser",
      "iap.tunnelResourceAccessor",
    ]
  }

  use_random = var.service_account_id == ""
  service_account_id = local.use_random ? (
    random_pet.service_account[0].id
  ) : var.service_account_id

  roles = flatten(concat(
    [for preset in var.preset_roles : local.presets[preset]],
    var.extra_roles
  ))

  now_plus_duration = timeadd(timestamp(), var.duration)
  expires_at = var.reset_duration_on_apply ? (
    local.now_plus_duration
  ) : time_static.role_duration[0].rfc3339

  key_json = base64decode(google_service_account_key.key.private_key)
}

resource "random_pet" "service_account" {
  count     = local.use_random ? 1 : 0
  length    = 2
  separator = "-"
}

resource "google_service_account" "sa" {
  account_id   = local.service_account_id
  display_name = local.service_account_id
  description  = "Temporary service account created by Terraform"
}

resource "time_static" "role_duration" {
  count   = var.reset_duration_on_apply ? 0 : 1
  rfc3339 = local.now_plus_duration

  lifecycle {
    ignore_changes = all
  }
}

resource "google_project_iam_binding" "roles" {
  for_each = toset(local.roles)

  project = var.project_id
  role    = "roles/${each.key}"
  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]

  condition {
    expression = "request.time < timestamp(\"${local.expires_at}\")"
    title      = "expires_at_${local.expires_at}"
  }
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.sa.name
}

resource "local_sensitive_file" "key" {
  count = var.key_file != "" ? 1 : 0

  content         = local.key_json
  filename        = var.key_file
  file_permission = "0400"
}
