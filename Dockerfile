FROM ruby:3.3.0

RUN apt-get update -qq && \
    apt-get install -y \
    nodejs \
    npm \
    postgresql-client \
    imagemagick \
    libvips \
    curl \
    gnupg

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
