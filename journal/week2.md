# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need ot create a Gemfile and define you gems in that file.

```rb
source: "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command.

This will install the gems on the system globally (unlike nodejs which installs the packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed.  This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.  

Its great for mock or developement servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read, Update and Delete.

[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)

### Terraform Cloud and Muli-Home Refactor

We did some refactoring which allowed us to clean up our code and make it more readable.  We also implemented the ability
to create more than one terrahouse if desired.
### HTML Adventure

Prior to this, I had little experience with HTML.  I found the below pages helpful so that I could create my page

[Elemments and Structure](https://codeacademy.com/learn/learn-html/modules/learn-html-elements/cheatsheet)

### Final Thoughts

I came into this bootcamp with limited experience and not sure how quickly I would learn and was afraid I would fall behind
I leave the bootcamp with an understanding of Terraform and a completed project.  I am proud of the lessons I learned and the
fact that I was able to stick with it through to the end.  Although frustrating at time, I found that I have learned more
troubleshooting skills and was even able to pick up on some of Andrew's famous code traps.  I am thankful for this experience
and can't wait for the next bootcamp.