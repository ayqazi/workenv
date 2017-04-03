#!/bin/bash

set -e

ANSIBLE_VERSION=2.2.0.0

if ! which ansible &> /dev/null || \
                [ "$(ansible --version | head -n1 | cut -d' ' -f2)" != "${ANSIBLE_VERSION}" ] ; then
        apt-get update
        apt-get -y install libssl-dev libffi-dev python-pip
        pip install ansible==2.2.0.0
fi
