FROM ruby:latest

ENV VIPSVER 8.9.1
RUN apt update && apt -y upgrade &&\
    apt install -y build-essential

RUN wget -O ./vips-$VIPSVER.tar.gz https://github.com/libvips/libvips/releases/download/v$VIPSVER/vips-$VIPSVER.tar.gz

RUN tar -xvzf ./vips-$VIPSVER.tar.gz && cd vips-$VIPSVER && ./configure && make && make install

COPY ./Gemfile /photo-stream/Gemfile 

WORKDIR /photo-stream

RUN ruby -v && gem install bundler jekyll && bundle install

COPY ./ /photo-stream/
 
EXPOSE 4000

ENTRYPOINT bundle exec jekyll serve
