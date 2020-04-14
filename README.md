# README

## Description
This is a simple Rails application to monitor network speed over time.

![](https://github.com/hansonryne/assets/blob/master/speedtest/index.png?raw=true)

### Dependencies
This can be run entirely in Docker and docker-compose using the commands below.
The base image is a custom version of Ruby's ```ruby:alpine3.10``` which can be found on DockerHub.

Just install any dependencies for Rails (and rsync) in that base image and it should be good to go.

### Installing and Running
An environment file needs to be built in the root of the directory before the application can start successfully.

```
cd repository
vim .env
```

Copy/Paste/Modify the following environment variables
```
# Rails ENV variables
DATABASE_USER=sammy
# UPDATE THIS
DATABASE_PASSWORD=shark
DATABASE_NAME=speedtest_database
DATABASE_HOST=database
RAILS_ENV=development
RAILS_SERVE_STATIC_FILES=true
# UPDATE THIS
SECRET_KEY_BASE=supers3cr3tpassword

#Point Bundler at /gems. This will cause Bundler to re-use gems that have already been installed on the gems volume
BUNDLE_PATH=/gems
BUNDLE_HOME=/gems

# Increase how many threads Bundler uses when installing. Optional!
BUNDLE_JOBS=4
# How many times Bundler will retry a gem download. Optional!
BUNDLE_RETRY=3

# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
GEM_HOME=/gems
GEM_PATH=/gems

# For the Postgres container
POSTGRES_DB=speedtest_database
POSTGRES_USER=sammy
# UPDATE THIS
POSTGRES_PASSWORD=shark
```

The application can be built and run with 

```
docker-compose up -d --build
```

The first time building everything will take a while because of yarn installation.

### Thanks
* chartkick gem
* whenever gem
* speedtest gem
* https://stackoverflow.com/questions/51097652/install-node-modules-inside-docker-container-and-synchronize-them-with-host

