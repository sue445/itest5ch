#!/bin/bash -xe

ruby --version
bundle --version
gem --version

bundle install --path=vendor/bundle || bundle update
