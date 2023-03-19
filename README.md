# Tap service
### Environment server

Ruby 2.7.1
Rails 7.0.4
bundler 2.1.4

## Preparation of the workplace
#### Install git
````bash
sudo apt install git
````
## Clone project in your workspace
````bash
git clone git@github.com:Venjaminnn/tap.git
````

## Install Ruby
Install by rvm (recommended)
````bash
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs

sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm


rvm install 2.7.1
rvm use 2.7.1 --default
ruby -v

````

### Install bundler

```bash
gem install bundler
```

### Install Rails

```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 7.0.4
rails -v
```

### Install postgresql 12

Update system packages
```bash
sudo apt update
sudo apt -y install vim bash-completion wget
sudo apt -y upgrade
```
Then need to reboot
After reboot need to import GPG key and add PostgreSQL 12 repository into Ubuntu Machine
And install PostgreSQL 12 server and client packages

```bash
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list

sudo apt update
sudo apt -y install postgresql-12 postgresql-client-12
psql --version
```
### Configuration and start project
All actions do in root folder of project

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails s
```

### Testing by rspec
All actions do in root folder of project

```bash
RAILS_ENV=test bin/rails db:create
RAILS_ENV=test bin/rails db:migrate
bundle exec rspec spec
```

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails s
```