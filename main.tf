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
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
#module "terrahouse_aws" {
 #   source = "./modules/terrahouse_aws"
  #  user_uuid = var.user_uuid
  #  bucket_name = var.bucket_name
  #  index_html_filepath = var.index_html_filepath
  #  error_html_filepath = var.error_html_filepath
  #  content_version = var.content_version
  #  assets_path = var.assets_path 
#}

resource "terratowns_home" "home" {
  name = "GOAT ANIME TO WATCH!"
  description = <<DESCRIPTION
One Piece isn't just any anime; it's an epic journey through treacherous seas and mysterious islands. 
As the crew searches for the legendary treasure, the "One Piece", they face powerful enemies, uncover hidden pasts, and challenge the very definition of a pirate's life. 
A true storytelling masterpiece, this anime continues to captivate audiences globally, showcasing that sometimes, the journey is even more valuable than the destination. 
This guide delves into the GOAT anime realm, and One Piece undoubtedly stands as one of my all-time favorites.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "video-valley"
  content_version = 1
}