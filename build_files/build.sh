#!/bin/bash

set -ouex pipefail

rpm -Uvh http://mirror.ppa.trinitydesktop.org/trinity/rpm/f42/trinity-r14/RPMS/noarch/trinity-repo-14.1.4-1.fc42.noarch.rpm

# RPMFusion (required for some Trinity packages)
dnf5 -y install rpmfusion-{free,nonfree}-release

# Prepare directories
rm /opt
mkdir /opt

PACKAGES=(
trinity-desktop-all
brightnessctl
redshift
)

dnf5 -y install ${PACKAGES[@]}

# SELinux breaks tdm unfortunately
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# I don't like Firefox personally
dnf5 -y remove firefox

# Enable tdm
systemctl enable tdm

systemctl enable podman.socket
