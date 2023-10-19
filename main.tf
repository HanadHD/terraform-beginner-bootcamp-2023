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
  cloud {
    organization = "hdcloud"

    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}
module "home_anime_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.anime.public_path
    content_version = var.anime.content_version
}

resource "terratowns_home" "home" {
  name = "GOAT 🏆 Anime to Watch!"
  description = <<DESCRIPTION
One Piece isn't just any anime; it's an epic journey through treacherous seas and mysterious islands. 
As the crew searches for the legendary treasure, the "One Piece", they face powerful enemies, uncover hidden pasts, and challenge the very definition of a pirate's life. 
A true storytelling masterpiece, this anime continues to captivate audiences globally, showcasing that sometimes, the journey is even more valuable than the destination. 
This guide delves into the GOAT anime realm, and One Piece undoubtedly stands as one of my all-time favorites.
DESCRIPTION
  domain_name = module.home_anime_hosting.domain_name
  #domain_name = "3fdq68853hdh.cloudfront.net"
  town = "video-valley"
  content_version = 1
}

module "home_warzone_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.warzone.public_path
  content_version = var.warzone.content_version
}

resource "terratowns_home" "home_warzone" {
  name = "Warzone Central"
  description = <<DESCRIPTION
Dive into Warzone, the pinnacle of battle royale experiences set in the vast universe of Verdansk. 
As you parachute into a dynamic battlefield filled with up to 150 players, every decision, from navigating urban streets to choosing your arsenal, becomes crucial. 
Beyond mere survival, Warzone tests strategy and skill, offering a rich blend of weapons, vehicles, and equipment to aid in your quest for victory. 
Whether teaming up with friends or going solo, engage in intense firefights, stealthy takedowns, and thrilling aerial combats. 
With ever-evolving game modes and challenges, Warzone promises endless action and excitement for both seasoned shooter fans and newcomers alike. 
Are you prepared for the ultimate battle?
DESCRIPTION
  domain_name = module.home_warzone_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.warzone.content_version
}