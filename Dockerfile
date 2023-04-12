FROM ruby:3.2.1-alpine

RUN apk add --update --no-cache postgresql-dev tzdata build-base && \
    rm -rf /var/cache/apk/*

RUN gem install bundler

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

ENV RACK_ENV production
ENV TZ UTC

EXPOSE 2300