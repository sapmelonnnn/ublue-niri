#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 -y copr enable bieszczaders/kernel-cachyos
rpm -e $(rpm -qa | grep '^kernel-core') --nodeps
dnf5 -y install kernel-cachyos-devel
dnf5 -y copr disable bieszczaders/kernel-cachyos

# Install Quickshell + dependencies
dnf5 -y copr enable errornointernet/quickshell
dnf5 -y install quickshell
dnf5 -y copr disable errornointernet/quickshell

# Noctalia dependencies
dnf5 -y copr enable wef/cliphist
dnf5 -y install cliphist
dnf5 -y copr disable wef/cliphist

dnf5 -y copr enable heus-sueh/packages
dnf5 -y install matugen
dnf5 -y copr disable heus-sueh/packages

# this installs a package from fedora repos
dnf5 install -y \
  niri \
  xwayland-satellite \
  hyprpaper \
  wl-clipboard \
  brightnessctl \
  cava \
  rofi-wayland \
  fd-find \
  ripgrep \
  fzf \
  zoxide \
  kitty \
  thunar \
  gvfs \
  gvfs-mtp \
  tumbler \
  file-roller \
  grim \
  slurp \
  playerctl \
  network-manager-applet \
  polkit-gnome \
  thunar-volman \
  thunar-archive-plugin \
  pavucontrol \
  noto-fonts-emoji \
  papirus-icon-theme \
  sddm \
  xdg-desktop-portal-gtk
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable sddm
systemctl enable podman.socket
