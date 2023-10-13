terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
 #backend "remote" {
   # hostname = "app.terraform.io"
    #organization = "hdcloud"

    # workspaces {
    #  name = "terra-house-1"
   # }
  #}
  #cloud {
   # organization = "hdcloud"

    #workspaces {
    #  name = "terra-house-1"
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
  name = "GOAT 🏆 Anime to Watch!"
  description = <<DESCRIPTION
One Piece isn't just any anime; it's an epic journey through treacherous seas and mysterious islands. 
As the crew searches for the legendary treasure, the "One Piece", they face powerful enemies, uncover hidden pasts, and challenge the very definition of a pirate's life. 
A true storytelling masterpiece, this anime continues to captivate audiences globally, showcasing that sometimes, the journey is even more valuable than the destination. 
This guide delves into the GOAT anime realm, and One Piece undoubtedly stands as one of my all-time favorites.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fdq68853hdh.cloudfront.net"
  town = "missingo"
  content_version = 1
}