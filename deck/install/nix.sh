#! /usr/bin/env sh

nix-env -iA nixpkgs.neovim
nix-env -iA nixpkgs.nodejs
nix-env -iA nixpkgs.go
nix-env -iA nixpkgs.gcc
nix-env -iA nixpkgs.make
nix-env -iA nixpkgs.cmake
nix-env -iA nixpkgs.gnumake
nix-env -iA nixpkgs.powerline-fonts
nix-env -iA nixpkgs.xclip
nix-env -iA nixpkgs.fzf
nix-env -iA nixpkgs._1password-gui
nix-env -iA nixpkgs.delve
# sudo nix-env -iA nixpkgs.openvpn
# sudo nix-env -iA nixpkgs.networkmanager-openvpn

