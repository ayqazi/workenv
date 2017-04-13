#!/bin/bash

cd "$(dirname ${0})/.."

set -x

ansible-playbook -i localhost, -c local -l localhost vm.yaml "${@}"
