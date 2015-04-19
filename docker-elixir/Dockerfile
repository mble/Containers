FROM phusion/baseimage:0.9.16
MAINTAINER Matt Blewitt <blewitt.matt+docker@gmail.com>

WORKDIR /root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Set timezone + locale
RUN echo "en_GB.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && dpkg-reconfigure -f noninteractive locales && \
    echo "LANG=en_GB.UTF-8" > /etc/default/locale && \
    echo "Europe/London" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

# Install elixir deps
RUN curl http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -o /root/erlang-solution_1.0_all.deb && \
    dpkg -i /root/erlang-solution_1.0_all.deb && \
    apt-get update && apt-get install -y unzip erlang-base-hipe erlang-inets erlang-ssl wget git build-essential && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/erlang-solutions_1.0_all.deb

# Install elixir 1.0.3
RUN curl -L https://github.com/elixir-lang/elixir/releases/download/v1.0.3/Precompiled.zip -o /root/elixir-1.0.3.zip && \
    unzip /root/elixir-1.0.3.zip -d /usr/local/elixir-1.0.3 && \
    rm -f /root/elixir-1.0.3.zip

# Symlink iex, mix etc
RUN ln -s /usr/local/elixir-1.0.3/bin/elixir /usr/local/bin/ && \
    ln -s /usr/local/elixir-1.0.3/bin/elixirc /usr/local/bin/ && \
    ln -s /usr/local/elixir-1.0.3/bin/iex /usr/local/bin/ && \
    ln -s /usr/local/elixir-1.0.3/bin/mix /usr/local/bin/

# Install local Elixir hex and rebar
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force
