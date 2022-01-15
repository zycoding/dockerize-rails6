# Dockerfile development version
FROM ruby:2.7.5 AS rails6_demo_app-development

ARG USER_ID
ARG GROUP_ID

RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY rails6_demo_app/ .
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install
RUN yarn install
RUN chown -R user:staff /opt/app

USER $USER_ID

EXPOSE 3000

RUN SECRET_KEY_BASE=1 
RUN RAILS_ENV=development 


# CMD bundle exec puma -e production -C config/puma/production.rb
CMD ["bundle", "exec", "puma", "-C", "config/puma/production.rb"]
