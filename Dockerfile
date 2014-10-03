FROM debian
MAINTAINER Pierpaolo Frasa <pfrasa@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y curl \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev

# Install ruby-build
RUN curl -L https://github.com/sstephenson/ruby-build/archive/v20140926.tar.gz -o ruby-build.tar.gz &&\
  tar -xzf ruby-build.tar.gz &&\
  rm ruby-build.tar.gz &&\
  ruby-build-20140926/install.sh &&\
  rm -rf ruby-build-20140926

# Install Ruby 2.1.2 and Bundler
RUN /usr/local/bin/ruby-build 2.1.2 /opt/ruby-2.1.2
RUN /opt/ruby-2.1.2/bin/gem install bundler

# set up path for all users
ENV PATH /opt/ruby-2.1.2/bin:$PATH
RUN echo "PATH=/opt/ruby-2.1.2/bin:$PATH" >> /etc/profile
