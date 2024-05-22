variable "secret_variable" {}
variable "nonsecret_variable" {}

# Get the Secret Variable directly from the variable (this is the most obvious path)
output "secret_by_direct_variable" {
  value = nonsensitive(var.secret_variable)
}

# Get Secret Variable by reading the environment variable
data "environment_variable" "secret" {
  name = "secret_variable"
}

output "secret_by_environment_variable" {
  value = data.environment_variable.secret.value
}

# Get the entire Terraform TFVARS file
data "environment_variable" "run-id" {
  name = "TF_VAR_TFC_RUN_ID"
}

data "local_file" "varsfile" {
  filename = "/home/tfc-agent/.tfc-agent/component/terraform/runs/${data.environment_variable.run-id.value}/terraform.tfvars"
}

output "local-tfvars" {
  value = data.local_file.varsfile.content
}
