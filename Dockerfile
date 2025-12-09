# Dockerizing blog
FROM ubuntu:25.04

# Update apt-get sources AND install protobof AND MongoDB
RUN apt-get update -q
# confirm git is installed
RUN apt-get install -y git vim
RUN apt-get -y -q install rubygems-integration ruby-dev make gcc ruby-execjs ruby-full build-essential zlib1g-dev
RUN gem install jekyll bundler

# Expose jekyll port
EXPOSE 4000

WORKDIR /root

# run terminal
CMD ["/bin/bash"]
