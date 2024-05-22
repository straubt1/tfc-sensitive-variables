variable "organization" {
  type = string
}

variable "workspace_name" {
  type    = string
  default = "ws-with-sensitive-variables"
}

resource "random_pet" "project" {
}

resource "tfe_project" "this" {
  organization = var.organization
  name         = random_pet.project.id
}

resource "tfe_workspace" "this" {
  organization = var.organization
  name         = var.workspace_name
  project_id   = tfe_project.this.id
}

resource "random_string" "sensitive" {
  length = 12
}

resource "tfe_variable" "sensitive" {
  key          = "secret_variable"
  value        = random_string.sensitive.result
  category     = "terraform"
  workspace_id = tfe_workspace.this.id
  sensitive    = true
  description  = "A variable with a secret value"
}

resource "tfe_variable" "nonsensitive" {
  key          = "nonsecret_variable"
  value        = "nothing important"
  category     = "terraform"
  workspace_id = tfe_workspace.this.id
  sensitive    = false
  description  = "A variable without a secret value"
}

output "secret_variable" {
  value = random_string.sensitive.result
}
