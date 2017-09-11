#!/bin/bash

set -u

HOME="$(getent passwd $(id -u) | cut -d: -f6)"
mygit() {
	git --git-dir="${HOME}/.homebak/.git" --work-tree="${HOME}" "${@}"
}

mkdir -p "${HOME}/.homebak"
cd "${HOME}/.homebak"
mygit init .
mygit remote add -f origin https://github.com/ayqazi/homebak.git
mygit checkout master
