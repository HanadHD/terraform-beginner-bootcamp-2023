# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

A package manager for Ruby. It is the primary way to install ruby packages, known as gems for ruby.

#### Installing Gems

To include gems in your project, define them in a `Gemfile`.

```Gemfile
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the gems on the system globally (unlike NodeJS that installs packages in place in a folder called node_modules)

A gemfile.lock will be created to lock down gem versions being used in this project

#### Executing Ruby Scripts in the Content of Bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra 

Sinatra is a lightweight web framework in Ruby, ideal for crafting simple applications or mock servers.

With just a few lines of code, you can set up a functional web server.

You can create a web-server in a single file.

[Sinatra](https://sinatrarb.com)

## TerraTowns Mock Server

### Running the Web Server

To get the server running:

```rb
bundle install  # Install the necessary gems
bundle exec ruby server.rb  # Start the server
```

All of the code for our websever is installed in our server.rb file

## CRUD

Terraform Provider resources are based on CRUD principles.

**CRUD** stands for:

- **C**: Create
- **R**: Read
- **U**: Update
- **D**: Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete 

## Terrahome AWS

```tf
module "home_anime" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.anime_public_path
  content_version = var.content_version
}
```

THe public directory expects the following:
- index.html
- error.html
- assets

All top level files in assets will be copied, but not any subdirectories.