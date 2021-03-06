FROM ruby:2.4.0

RUN mkdir -p /var/www/social-recipe
WORKDIR /var/www/social-recipe
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

RUN apt-get update
RUN apt-get install nodejs -y
COPY . /var/www/social-recipe

CMD rails server -b 0.0.0.0
