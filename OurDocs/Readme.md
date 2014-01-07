## Contributors

Andrew O'Mahony - andrewsomahony@gmail.com

## Notes

Most of these instructions have only been tested on my OSX machine.

## Project Documents

The "OurDocs" folder is where project-specific documents will be stored.  However, I would
like these documents to also be stored on Google Docs so we can use them within Google Hangouts

## Back-End Technologies

Ruby on Rails application

- Ruby 2.0.0
- Rails 4.0.1
- PostgreSQL 9.2 (with hstore extension planned)
- Thin (lightweight http server) for development

## Front-End Technologies

- CoffeeScript: Used in place of Javascript, compiles into Javascript [CoffeeScript](http://coffeescript.org)
- HAML: Used for all layouts, compiles into HTML [HAML](http://haml.info)
- SASS: Used for all stylesheets, compiles into CSS [SASS](http://sass-lang.com)

## Coding Style

Use spaces instead of tabs
Each tab represents 3 spaces
You can download a SublimeText preferences file for this

All brackets should go on the line following the statement (their own line)

For CoffeeScript:

if (variableIsTrue)
{
   console.log("It is true!")
}

For SASS:

div.somestyle
{
   color: red;
}

In CoffeeScript, any jQuery object should be prefixed with a '$'
A jQuery object is any variable that is attained using jQuery methods

Example:

var $html = $('html')
var string = "Hello"

## Setting up Git

The source code is hosted on a GitHub server.

You can install git and read a bit about it here: [Git](https://help.github.com/articles/set-up-git)

To clone the repository, simply open a Terminal, change to the directory you want the source *folder*
to go, and type:

git clone -b master https://github.com/aomahony/thegamecollaboratory.git

Into your terminal window.

## Developer Setup

0. Use the master branch.  In your git checkout of thegamecollaboratory
        git checkout master

1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

2. Install Ruby if necessary. For Mac, Ruby and Rubygems are already installed. For Windows use the [RubyInstaller](http://rubyinstaller.org/).

3. [Download](http://downloads.vagrantup.com) and install Vagrant, or in Terminal use
        gem install vagrant

4. In Terminal, `cd vm` in your git checkout of thegamecollaboratory.

5. Download the base virtual machine (~300 MB)
        vagrant box add precise64 http://files.vagrantup.com/precise64.box

6. Run and enter the VM (see "running vagrant" section below for more).  `vagrant up` will take 5-10 minutes.
*Note:* if you're running Windows, you'll need to jump through some extra hoops (not documented here) rather than use `vagrant ssh`.  See http://vagrantup.com/v1/docs/getting-started/ssh.html for more.
        vagrant up
        vagrant ssh
        cd thegamecollaboratory

7. Setup Rails
        sudo apt-get install libpq-dev  # Enter "Y" when prompted
        bundle install

*NOTE* If you get an error saying that bundler cannot continue, follow step 7a
OTHERWISE skip to step 8

7a. Set permissions

   Type these commands:
   cd /usr/local/rvm/gems/
   ls -l

   *You should see a file named something like ruby-2.0.0-pXXX * Where XXX is a number.

   Type:
   sudo chown -R vagrant ruby-2.0.0-pXXX

   Where XXX is the number you see

   Type:
   cd ~/thegamecollaboratory
   bundle install

8. Setup the database
        rake db:create
        rake db:migrate
        rake db:seed

  If you get this error:
    "PG::Error: ERROR:  encoding "UTF8" does not match locale "en_US"
  then run these commands and restart step 8:
        psql -U caligula -h localhost -d postgres  # password 4R^tYdald3R
        update pg_database set datistemplate = FALSE where datname = 'template1';
        drop database template1;
        create database template1 with template = template0 encoding = 'UTF8' LC_CTYPE = 'en_US.utf8' LC_COLLATE = 'en_US.utf8';
        update pg_database set datistemplate = TRUE where datname = 'template1';
        \q

9. To run the Rails server and test out your work, type:
   "rails s"
   in the Terminal 
   and then open your browser and surf to "http://localhost:3000"

## Development Process

Each time you sit down to work:

1. In Terminal, `cd vm` in your git checkout.

2. Run and enter the VM
        vagrant up
        vagrant ssh
        cd thegamecollaboratory

3. Update Rails
        bundle install
        rake db:migrate

4. Run services
        rails s

5. Interact with Rails
    - open http://localhost:3000 in your web browser
    - enter the rails console with `rails console`
    - enter the database console with `rails db` (or on the staging server, `RAILS_ENV=staging rails db -p`)

I'd like all work to be done on our own remote branches.

To make a remote branch, simply type "git checkout -b $BRANCH_NAME" where $BRANCH_NAME is the name of the branch

I'd like the branches to be named after the developer, so if your name is "Julius Caesar",
then the branch name is: "jcaesar_dev"

When you've made some changes, you need to commit them to your branch.  To do this, navigate up to the project's
root directory (the one with the source and vm and OurDocs folders) and type:

git add .
git add -u .
git commit -m"$YOUR_NAME:$MESSAGE"

where $YOUR_NAME is your first initial and last name, ("Julius Caesar" = "jcaesar")
where $MESSAGE is a detailed message of what you've done in the commit.

Then, to push to your remote branch, simply type: "git push origin $BRANCH_NAME"
where $BRANCH_NAME is the name of your branch

## Deployment

Currently, I'm the only one who can deploy, but I'm writing this down more for knowledge.

Surf to the project's root directory and type:

git subtree push --prefix source/thegamecollaboratory heroku master

Then type:

heroku run rake db:migrate