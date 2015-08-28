# Dockerizing blog

FROM ubuntu:15.04
MAINTAINER A. Seurat <alban.seurat@me.com>

# Update apt-get sources AND install protobof AND MongoDB
RUN apt-get update -q
# confirm git is installed
RUN apt-get install -y git
RUN apt-get -y -q install rubygems-integration ruby-dev make gcc ruby-execjs
RUN gem install jekyll

# Expose jekyll port
EXPOSE 4000

WORKDIR /root/projects/timeline-jekyll-theme

# run terminal
CMD ["/bin/bash"]
