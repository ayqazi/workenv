#!/bin/bash

set -e

ANSIBLE_VERSION=2.8.12

if ! which ansible &> /dev/null || \
                [ "$(ansible --version | head -n1 | cut -d' ' -f2)" != "${ANSIBLE_VERSION}" ] ; then
        apt-get update
        apt-get -y install libssl-dev libffi-dev python3-pip
        pip3 install ansible=="${ANSIBLE_VERSION}"
fi
