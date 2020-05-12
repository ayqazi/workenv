#!/bin/bash -ux

echo "Starting at $(+%F-%T)..." >> /var/log/create-home-dir.log
exec > >(tee -ai /var/log/create-home-dir.log)
exec 2>&1

HOME="$(getent passwd $(id -u) | cut -d: -f6)"
mygit() {
	git --git-dir="${HOME}/.homebak/.git" --work-tree="${HOME}" "${@}"
}

mkdir -p "${HOME}/.homebak"
cd "${HOME}/.homebak"
mygit init .
mygit remote add -f origin https://github.com/ayqazi/homebak.git
mygit checkout master

chmod 700 "${HOME}/.ssh"
"${HOME}/bin/assemble-ssh-config"
