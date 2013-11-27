 git subtree push --prefix source/thegamecollaboratory heroku master

##Project Documents

The "OurDocs" folder is where project-specific documents will be stored.  However, I would
like these documents to also be stored on Google Docs so we can use them within Google Hangouts

## Tech stack

Ruby on Rails application

- Ruby 2.0.0
- Rails 4.0.1
- PostgreSQL 9.2 (with hstore extension planned)
- Thin (lightweight http server) for development

## Developer Setup

0. Use the development branch.  In your git checkout of tagcatalog
        git checkout development

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
*Note:* if you get an error saying that Bundler cannot continue, run "bundle update" then "bundle install"

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