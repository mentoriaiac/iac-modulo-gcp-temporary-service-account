# iac-modulo-gcp-temporary-service-account

Módulo para a criação de credenciais temporárias para permitir acesso a um
projeto GCP.

## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google)          | ~>4.16.0 |
| <a name="requirement_local"></a> [local](#requirement\_local)             | ~>2      |
| <a name="requirement_random"></a> [random](#requirement\_random)          | ~>3      |
| <a name="requirement_time"></a> [time](#requirement\_time)                | ~>0      |

## Providers

| Name                                                       | Version  |
|------------------------------------------------------------|----------|
| <a name="provider_google"></a> [google](#provider\_google) | ~>4.16.0 |
| <a name="provider_local"></a> [local](#provider\_local)    | ~>2      |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3      |
| <a name="provider_time"></a> [time](#provider\_time)       | ~>0      |

## Resources

| Name                                                                                                                                   | Type     |
|----------------------------------------------------------------------------------------------------------------------------------------|----------|
| [google_project_iam_binding.roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_service.compute_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service)   | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account)            | resource |
| [google_service_account_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key)   | resource |
| [local_sensitive_file.key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file)               | resource |
| [random_pet.service_account](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet)                       | resource |
| [time_static.role_duration](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static)                       | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_duration"></a> [duration](#input\_duration) | Tempo de duração em que a service account terá permissão para utilizar as<br>roles atribuídas. Definido como número e unidade, por exemplo, 3h ou 2h30m.<br>Valor padrão de 2h. | `string` | `"2h"` | no |
| <a name="input_extra_roles"></a> [extra\_roles](#input\_extra\_roles) | Lista de roles a serem associadas à service account. | `list(string)` | `[]` | no |
| <a name="input_key_file"></a> [key\_file](#input\_key\_file) | Caminho onde a chave privada da service account será salva. Se não for<br>definido a chave não será salva em um arquivo e poderá ser acessada através<br>do output `key_json`. | `string` | `""` | no |
| <a name="input_preset_roles"></a> [preset\_roles](#input\_preset\_roles) | Lista de presets de roles a serem associadas à service account. Valores<br>válidos de presets são: packer. | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID do project onde a service account será criada. | `string` | n/a | yes |
| <a name="input_reset_duration_on_apply"></a> [reset\_duration\_on\_apply](#input\_reset\_duration\_on\_apply) | Se definido como true, o tempo de duração da permissão será extendido a<br>cada apply. | `bool` | `true` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | ID que será definid para a service account. Se não for definido um nome<br>aleatório será utilizado. | `string` | `""` | no |

## Outputs

| Name                                                                                           | Description                                              |
|------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| <a name="output_key_json"></a> [key\_json](#output\_key\_json)                                 | Chave privada da service account criada em formato JSON. |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | ID da service account criada.                            |

## Como usar esse módulo
[Acesse o passo-a-passo](how-to-use-this-module/README.md)
