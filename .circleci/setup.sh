#!/bin/bash -xe

ruby --version
bundle --version
gem --version

bundle update
bundle clean
