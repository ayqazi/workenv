#!/bin/bash -e

cd "$(dirname ${0})/.."

HOME="$(getent passwd "${USER}" | cut -d: -f6)"

set -x

ansible-playbook -i localhost, -c local -l localhost vm.yaml "${@}"
