#!/bin/bash

set -ouex pipefail

rpm -Uvh http://mirror.ppa.trinitydesktop.org/trinity/rpm/f42/trinity-r14/RPMS/noarch/trinity-repo-14.1.4-1.fc42.noarch.rpm

# Prepare directories
mkdir -p /usr/lib/opt/trinity
mkdir -p /var/opt
ln -s /usr/lib/opt/trinity /var/opt/trinity

COPR_REPOS=(
ublue-os/packages
)

PACKAGES=(
trinity-tdebase
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


systemctl enable podman.socket
