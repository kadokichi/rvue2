FROM ruby:3.3.2

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN gem update --system

RUN mkdir /apps
WORKDIR /apps

COPY ./apps/Gemfile       /apps/Gemfile
COPY ./apps/Gemfile.lock  /apps/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
