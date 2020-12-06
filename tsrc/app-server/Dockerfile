FROM ubuntu:16.04
MAINTAINER Pavel Taranov <pavel.a.taranov@gmail.com>



# Basic tools
RUN apt update \
 && apt install --yes curl



# Install node
RUN curl https://nodejs.org/dist/v6.12.0/node-v6.12.0-linux-x64.tar.gz > /tmp/node-v6.12.0-linux-x64.tar.gz \
 && cd /tmp \
 && tar zxf node-v6.12.0-linux-x64.tar.gz \
 && cd node-v6.12.0-linux-x64 \
 && cp -rf ./bin     /usr/local \
 && cp -rf ./include /usr/local \
 && cp -rf ./lib     /usr/local \
 && cp -rf ./share   /usr/local



# Fetch application
COPY . /app-server



# Install node packages required by app.
RUN cd /app-server \
 && npm install assert



ENTRYPOINT /app-server/entrypoint.sh
