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
  endpoint = "http://localhost:4567/api"
  user_uuid = "8b684a87-9ef6-4a4a-a69b-8ef8dadea974"
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

#module "terrahouse_aws" {
#    source = "./modules/terrahouse_aws"
#    user_uuid = var.user_uuid
#    bucket_name = var.bucket_name
#    index_html_filepath = var.index_html_filepath
#    error_html_filepath = var.error_html_filepath
#    content_version = var.content_version 
#    assets_path = var.assets_path
#}

resource "terratowns_home" "home" {
  name = "Smoking the Perfect Brisket!"
  description = <<DESCRIPTION
Smoking the perfect brisket takes patience and time.  You can't rush a good thing!
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "23fdq3gz.cloudfront.net"
  town = "cooker-cove"
  content_version = 1
}



