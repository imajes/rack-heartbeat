#!/bin/bash -e

gem install -N bundler
bundle
bundle exec rake jenkins
