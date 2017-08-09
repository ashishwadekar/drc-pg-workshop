# Installation and Setup for: What Lies Beneath ( your models )

[![Join the chat at https://gitter.im/drc-pg-workshop/Lobby](https://badges.gitter.im/drc-pg-workshop/Lobby.svg)](https://gitter.im/drc-pg-workshop/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
This guide will help you install the optimal setup in order to have a productive time at the workshop.  Guide is currently written for Mac OS X, but it easy enough to follow along for any modern Linux distribution as well.

## Requirements
1. Operating system: Mac OS X or Ubuntu recommended.  Microsoft Windows is _not supported_
2. Command line: Terminal, iTerm, etc.
3. Any Ruby version manager that supports `.ruby-version` file.  Recommended: [rbenv](https://github.com/rbenv/rbenv). Other options: [chruby](https://github.com/postmodern/chruby) or [rvm](https://rvm.io)
4. Ruby 2.3.x
5. Rails 5.x.x
6. PostgreSQL 9.5.4 and above
7. A working PostgreSQL client.
	1. Recommend: `psql`, comes bundled with PostgresSQL
	2. Other options: `pgcli` , Postico
8. Git.  Using a git repo to save your work is recommended, revisiting your Git history at a later date is quite valuable.
9. Your everyday code editor / IDE, configured to be used with Ruby, and Rails.  _We highly recommend that you use your regular setup, in order to avoid any friction with editing._


## Installation
### PostgreSQL

1. Check if you already have PostgreSQL installed.
	1. `pg_config --version`. If this errors, you probably don't have PG installed.
	2. If it shows a version, you're set. Move on to the next section.  Note: If you PostgreSQL version is older than 9.5.x, you should think about upgrading.  The guides will help with that: [Guide 1](https://keita.blog/2016/01/09/homebrew-and-postgresql-9-5/), [Guide 2](https://collectiveidea.com/blog/archives/2016/01/08/postgresql95-upgrade-with-homebrew)
2. For a fresh installation, [homebrew](https://brew.sh) is recommended.
3. `brew update && brew install postgresql`
4. Follow the instructions from `brew install` to initialise a PG database and start the service.  If you're stuck with some error, and Googling around isn't helping, reach out to us.
5. At this point `psql` should start without errors. And you should be able to run a query like:

```
# select version();

                                                    version
----------------------------------------------------------------------------------------------------------------
 PostgreSQL 9.5.6 on x86_64-apple-darwin16.4.0, compiled by Apple LLVM version 8.0.0 (clang-800.0.42.1), 64-bit
(1 row)
```

### Ruby Version Manager

Follow the installation instructions from the respective websites:

rbenv: https://github.com/rbenv/rbenv#installation
chruby: https://github.com/postmodern/chruby#install
rvm: https://rvm.io/rvm/install

### Ruby

`rbenv install 2.4.1`
`gem install bundler`

### Rails

1. Fork this Repo to your own Github account.
2. Clone your repo, by following instructions from GitHub.
3. `cd drc-pg-workshop`
4. Check Ruby version: `ruby -v` should show `2.4.1`
5. `bundle install`

## Test if everything is working
`./bin/rake` should work without errors, if it does, you're all set.

