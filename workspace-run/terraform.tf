terraform {
  cloud {
    organization = "terraform-tom" #update to your Organization Name

    workspaces {
      name = "ws-with-sensitive-variables"
    }
  }

  required_providers {
    environment = {
      source  = "MorganPeat/environment"
      version = "0.2.6"
    }
  }
}
