variable "project_id" {
  type        = string
  description = "ID do project onde a service account será criada."
}

variable "service_account_id" {
  type        = string
  default     = ""
  description = <<-EOF
    ID que será definid para a service account. Se não for definido um nome
    aleatório será utilizado.
  EOF
}

variable "preset_roles" {
  type        = list(string)
  default     = []
  description = <<-EOF
    Lista de presets de roles a serem associadas à service account. Valores
    válidos de presets são: packer.
  EOF

  validation {
    condition = alltrue(
      [for p in var.preset_roles : contains([
        "packer",
      ], p)]
    )
    error_message = "Presets válidos são: packer."
  }
}

variable "extra_roles" {
  type        = list(string)
  default     = []
  description = "Lista de roles a serem associadas à service account."
}

variable "duration" {
  type        = string
  default     = "2h"
  description = <<-EOF
    Tempo de duração em que a service account terá permissão para utilizar as
    roles atribuídas. Definido como número e unidade, por exemplo, 3h ou 2h30m.
    Valor padrão de 2h.
  EOF
}

variable "reset_duration_on_apply" {
  type        = bool
  default     = true
  description = <<-EOF
    Se definido como true, o tempo de duração da permissão será extendido a
    cada apply.
  EOF
}

variable "key_file" {
  type        = string
  default     = ""
  description = <<-EOF
    Caminho onde a chave privada da service account será salva. Se não for
    definido a chave não será salva em um arquivo e poderá ser acessada através
    do output `key_json`.
  EOF
}
