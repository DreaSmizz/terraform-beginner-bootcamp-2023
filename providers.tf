terraform {
  #backend "remote"{
  #  hostname = "app.terraform.io"
  #  organization = "Smith-Enterprises"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "Smith-Enterprises"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
#}
  required_providers {
        aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}