# Utilizando o módulo `iac-modulo-gcp-temporary-service-account`

## Dependências

Para realizar os testes localmente é necessário:

| Ferramentas  | Versão    | Instalação                                                            |
|--------------|-----------|-----------------------------------------------------------------------|
| Terraform    | >= 1.0.0  | [Acesse](https://learn.hashicorp.com/tutorials/terraform/install-cli) |
| `gcloud` CLI | >= 38.0.0 | [Acesse](https://cloud.google.com/sdk/docs/install)                   |

## Passo-a-passo

Crie um projeto no [console da GCP](https://console.cloud.google.com) e copie o
ID gerado.

Faça login na GCP usando a CLI do `gcloud` e defina o projeto criado como
padrão:

```console
$ export GCP_PROJECT=<ID DO PROJETO>
$ gcloud auth application-default login
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?response_type=code...

$ gcloud config set project $GCP_PROJECT
Updated property [core/project].
```

Inicialize o Terraform:

```console
$ terraform init
Initializing modules...
- tmp_packer_key in ..

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/google versions matching "~> 4.16.0"...
- Finding hashicorp/random versions matching "~> 3.0"...
- Finding hashicorp/local versions matching "~> 2.0"...
- Finding hashicorp/time versions matching "~> 0.0"...
- Installing hashicorp/google v4.16.0...
- Installed hashicorp/google v4.16.0 (signed by HashiCorp)
- Installing hashicorp/random v3.1.2...
- Installed hashicorp/random v3.1.2 (signed by HashiCorp)
- Installing hashicorp/local v2.2.2...
- Installed hashicorp/local v2.2.2 (signed by HashiCorp)
- Installing hashicorp/time v0.7.2...
- Installed hashicorp/time v0.7.2 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Aplique a configuração de exemplo:

```console
$ terraform apply -var project_id=$GCP_PROJECT

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.tmp_packer_key.google_project_iam_binding.roles["compute.instanceAdmin.v1"] will be created
  + resource "google_project_iam_binding" "roles" {
      + etag    = (known after apply)
      + id      = (known after apply)
      + members = (known after apply)
      + project = "..."
      + role    = "roles/compute.instanceAdmin.v1"

      + condition {
          + expression = (known after apply)
          + title      = (known after apply)
        }
    }

  # module.tmp_packer_key.google_project_iam_binding.roles["iam.serviceAccountUser"] will be created
  + resource "google_project_iam_binding" "roles" {
      + etag    = (known after apply)
      + id      = (known after apply)
      + members = (known after apply)
      + project = "..."
      + role    = "roles/iam.serviceAccountUser"

      + condition {
          + expression = (known after apply)
          + title      = (known after apply)
        }
    }

...

Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Confirme a ação e aguarde a execução terminar. Verifique que a service account
e as roles foram criadas:

```console
$ gcloud iam service-accounts list
DISPLAY NAME                            EMAIL                                               DISABLED
packer                                  packer@...                                          False
...

$ gcloud projects get-iam-policy $GCP_PROJECT
bindings:
- condition:
    expression: request.time < timestamp("2022-04-09T22:34:42Z")
    title: expires_at_2022-04-09T22:34:42Z
  members:
  - serviceAccount:packer@....iam.gserviceaccount.com
  role: roles/compute.instanceAdmin.v1
...

$ ls .keys
./  ../  packer.json
```
