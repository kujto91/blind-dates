ARG RUBY_VERSION=2.7.6
FROM registry.docker.com/library/ruby:$RUBY_VERSION

RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl gnupg git libpq-dev libvips pkg-config python-is-python3 nodejs

RUN npm install -g yarn esbuild

ENV APP_HOME /blind-dates

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
ADD .ruby-version $APP_HOME/.ruby-version

RUN bundle install

ADD . $APP_HOME

RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD bundle exec rails s -p 3000 -b '0.0.0.0'
