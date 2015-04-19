FROM mble/docker-elixir
MAINTAINER Matt Blewitt <blewitt.matt+docker@gmail.com>

# Install Phoenix from source
ENV PHOENIX_VERSION 0.11.0
RUN git clone https://github.com/phoenixframework/phoenix.git &&\
    cd phoenix && git checkout v$PHOENIX_VERSION &&\
    mix local.hex --force && mix local.rebar --force &&\
    mix do deps.get, compile &&\
    mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v$PHOENIX_VERSION/phoenix_new-$PHOENIX_VERSION.ez --force

# Install Node.js and NPM in order to satisfy brunch.io dependencies
ENV NODE_VERSION 0.12
ENV NPM_VERSION 2.7.3

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION | bash - &&\
    apt-get install -y nodejs &&\
    npm install -g npm@"$NPM_VERSION" &&\
    npm cache clear

# Kick off demo app
RUN mix phoenix.new hello_phoenix &&\
    cd hello_phoenix &&\
    mix do deps.get, compile &&\
    npm install
EXPOSE 4000
WORKDIR /root/hello_phoenix
CMD ["mix","phoenix.server"]
