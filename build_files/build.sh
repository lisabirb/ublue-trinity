#!/bin/bash

set -ouex pipefail

rpm -Uvh http://mirror.ppa.trinitydesktop.org/trinity/rpm/f42/trinity-r14/RPMS/noarch/trinity-repo-14.1.4-1.fc42.noarch.rpm

# Prepare directories
rm /opt
mkdir /opt

dnf -y group install base-x

COPR_REPOS=(
ublue-os/packages
)

PACKAGES=(
trinity-desktop
NetworkManager-tui
fastfetch
fish
ublue-brew
neovim
)

for i in ${COPR_REPOS[@]}; do
  dnf -y copr enable $i
done

dnf5 -y install ${PACKAGES[@]}

# SELinux breaks tdm unfortunately
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# I don't like Firefox personally
dnf5 -y remove firefox

# Enable tdm
systemctl enable tdm

systemctl enable podman.socket
