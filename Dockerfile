FROM ruby:2.7.1-alpine as builder

RUN apk --update add --virtual build-dependencies \
    alpine-sdk nodejs-current nodejs-npm yarn sqlite-dev python2 tzdata curl \
    build-base curl-dev linux-headers

WORKDIR /tmp
COPY Gemfile Gemfile.lock package.json yarn.lock /tmp/
RUN gem install bundler --no-document \
      -v $(grep "BUNDLED WITH" -A 1 Gemfile.lock | tail -n 1)

RUN bundle config set without 'development test'
RUN bundle config set deployment 'true'
RUN bundle config set jobs 4
RUN bundle install
RUN yarn install --production

RUN ls -lrt

RUN apk del build-dependencies


FROM ruby:2.7.1-alpine

ENV APP_ROOT /var/rails/
ENV TZ JST-9
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV PORT 3000
ENV RAILS_ENV production
ENV NODE_ENV production

RUN apk update
RUN apk add --no-cache \
    alpine-sdk nodejs-current nodejs-npm yarn sqlite-dev python2 tzdata curl

RUN mkdir -p ${APP_ROOT}
WORKDIR ${APP_ROOT}

COPY Gemfile Gemfile.lock package.json yarn.lock ${APP_ROOT}

RUN gem install bundler --no-document \
      -v $(grep "BUNDLED WITH" -A 1 Gemfile.lock | tail -n 1)

COPY --from=builder /root/.bundle/config /root/.bundle/config
COPY --from=builder /tmp/vendor/bundle ${APP_ROOT}vendor/bundle
COPY --from=builder /tmp/node_modules ${APP_ROOT}node_modules
RUN bundle install
ADD . ${APP_ROOT}

RUN bundle exec rake assets:precompile

EXPOSE ${PORT}

CMD bundle exec rails db:setup techpinterest:demodata:setup && bundle exec rails s -p ${PORT} -b 0.0.0.0

