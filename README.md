# tfc-sensitive-variables

## Setup Workspaces

`./workspace-create`

This folder contains Terraform to create and setup a Workspace with a few Variables (one that has a sensitive value).

`terraform apply -var="organization=terraform-tom"`

Resources:
- Project (name: "{Random Pet Name}")
  - Workspace (name: "ws-with-sensitive-variables")
    - Variables:
      - "secret_variable" (value: "{Random Password}")
      - "nonsecret_variable" (value: "nothing important")

## Execute Workspace Run

Plan level execution (speculative plan), does not impact state.

```
$ terraform plan
...
Changes to Outputs:
  + local-tfvars                   = <<-EOT
        nonsecret_variable = "nothing important"
        secret_variable = "b2KRueexDsZ5"
    EOT
  + secret_by_direct_variable      = "b2KRueexDsZ5"
  + secret_by_environment_variable = "b2KRueexDsZ5"
```
