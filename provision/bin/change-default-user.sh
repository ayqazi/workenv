#!/bin/bash

set -e

echo "Starting..." > /var/log/change-default-user.log
exec > >(tee -i /var/log/change-default-user.log)
exec 2>&1

groupmod -n ayqazi vagrant
usermod -l ayqazi -d /home/ayqazi vagrant

useradd -U -s /bin/bash -G sudo vagrant
chown -R vagrant:vagrant /home/vagrant
echo vagrant:vagrant | chpasswd

rm /etc/rc.local
