#!/bin/bash -e

docker build -t rack-heartbeat .

docker run --rm \
  -v $PWD/coverage:/usr/src/app/coverage \
  -v $PWD/test:/usr/src/app/test \
  rack-heartbeat \
    bundle exec rake jenkins
# gem install -N bundler
# bundle
# bundle exec rake jenkins
