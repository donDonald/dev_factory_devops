FROM ubuntu:20.04
MAINTAINER Pavel Taranov <pavel.a.taranov@gmail.com>



# Basic tools
RUN apt update \
 && apt install --yes curl



# Install node
RUN curl https://nodejs.org/download/release/latest-v14.x/node-v14.15.4-linux-x64.tar.gz > /tmp/node-linux.tar.gz \
 && cd /tmp \
 && mkdir node-linux \
 && tar zxf node-linux.tar.gz -C node-linux --strip-components 1 \
 && cp -rf ./node-linux/bin     /usr/local \
 && cp -rf ./node-linux/include /usr/local \
 && cp -rf ./node-linux/lib     /usr/local \
 && cp -rf ./node-linux/share   /usr/local



COPY . /example1-exporter



RUN cd /example1-exporter \
 && npm install assert \
 && npm install



ENTRYPOINT /example1-exporter/entrypoint.sh

