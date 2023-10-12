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
  cloud {
    organization = "Smith-Enterprises"
    workspaces {
      name = "terra-house-1"
    }
  }
#}
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_brisket_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.brisket.public_path
    content_version = var.brisket.content_version
}

resource "terratowns_home" "home_brisket" {
  name = "Smoking the Perfect Brisket!"
  description = <<DESCRIPTION
Smoking the perfect brisket takes patience and time.  You can't rush a good thing!
After moving into our house two years ago one of the first things I wanted to do was 
get into smoking meat.  I smoked my first brisket and haven't looked back since.  This
receipe I followed gave me a perfect, most brisket that everyone loved.
DESCRIPTION
  domain_name = module.home_brisket_hosting.domain_name
  town = "cooker-cove"
  content_version = var.brisket.content_version
}



