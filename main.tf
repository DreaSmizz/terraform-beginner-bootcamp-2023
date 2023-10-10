terraform {
  required_providers {
     terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
     }
    }
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
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.teacherseat_user_uuid
    index_html_filepath = var.index_html_filepath
    error_html_filepath = var.error_html_filepath
    content_version = var.content_version 
    assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Smoking the Perfect Brisket!"
  description = <<DESCRIPTION
Smoking the perfect brisket takes patience and time.  You can't rush a good thing!
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "23fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = 1
}



