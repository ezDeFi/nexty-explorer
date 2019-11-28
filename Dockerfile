FROM bitwalker/alpine-elixir-phoenix:1.9.0

RUN apk --no-cache --update add alpine-sdk gmp-dev automake libtool inotify-tools autoconf python

EXPOSE 4000

ENV PORT=4000

ADD . .

ARG COIN
RUN if [ "$COIN" != "" ]; then sed -i s/"POA"/"${COIN}"/g apps/block_scout_web/priv/gettext/en/LC_MESSAGES/default.po; fi

# Run forderground build and phoenix digest
RUN mix do deps.get, local.rebar --force, deps.compile, compile

# Add blockscout npm deps
RUN cd apps/block_scout_web/assets/ && \
    npm install && \
    node_modules/webpack/bin/webpack.js --mode production; \
    cd -

RUN cd apps/explorer/ && \
    npm install; \
    cd -

# RUN mix do ecto.drop --force, ecto.create, ecto.migrate

# USER default

# CMD ["mix", "phx.server"]
