#!/bin/bash

set -e

user_uid() {
        user="${1}"
        echo "$(getent passwd ${user} | cut -d: -f3)"
}

cd "$(dirname ${0})/.."

if [[ "$(id -un)" = vagrant && "$(user_uid vagrant)" = 1000 ]] ; then
        echo 'vagrant is uid 1000, script added to change this on reboot'
        echo 'Reboot machine to change this to you! (vagrant reload)'
        echo 'Continue provisioning (vagrant provision) after reboot'
        sudo -H cp /vagrant/provision/bin/change-default-user.sh /etc/rc.local
else
        echo 'Installing foundation packages, and provisioning'
        sudo -H "bin/install-foundation.sh"
        sudo -H "bin/full-provision.sh"
fi
