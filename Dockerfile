from ubuntu:16.04

MAINTAINER Michael Green

RUN    apt-get -y -q update
RUN    apt-get -y -q upgrade

ENV LANG en_US.utf8

RUN apt-get -y -q update
RUN apt-get install -y -q postgresql postgresql-contrib
RUN apt-get install -y -q memcached
RUN apt-get install -y -q redis-server
RUN apt-get install -y -q curl
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable

# Installing ruby version 2.3.3, cumbersome because it requires a login
# shell
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN /bin/bash -l -c "gem install juggernaut"
RUN /bin/bash -l -c "gem install bundler"
RUN /bin/bash -l -c "gem install rake"
RUN apt-get -y -q install git
WORKDIR /usr/src/app
RUN apt-get -y -q install build-essential patch ruby-dev zlib1g-dev liblzma-dev
RUN apt-get -y -q install libxml2-dev
RUN apt-get install -y -q libpq-dev
COPY . .
RUN /bin/bash -l -c "bundle install"
USER postgres
WORKDIR /usr/src/app
RUN /bin/bash -l -c 'service postgresql start; bash update-utf8.sh;'
RUN /bin/bash -l -c "service postgresql start; rake db:create; rake db:migrate; rake db:seed;"
RUN /bin/bash -l -c "mkdir -p /usr/src/app/tmp"
# Change these permissions later, this is terrible
USER root
RUN /bin/bash -l -c "chmod 777 /usr/src/app/tmp"
