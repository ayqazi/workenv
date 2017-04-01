#!/bin/bash

set -e

apt-get update
apt-get -y dist-upgrade
apt-get -y install python-pip
pip install ansible==2.2.0.0
