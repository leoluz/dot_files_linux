#! /usr/bin/env sh
set -euo pipefail

# https://wind010.hashnode.dev/installing-nordvpn-on-arch-linux
sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate


sudo pacman -Syu
sudo pacman -S yay
yay -S nordvpn-bin
pacman -Qs nordvpn
sudo systemctl enable nordvpnd
sudo systemctl start nordvpnd
sudo nordvpn set technology nordlynx
sudo nordvpn set killswitch enable
sudo nordvpn status
sudo steamos-readonly enable
sudo nordvpn login --legacy
