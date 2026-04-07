#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm rocksndiamonds-contrib

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

if [ "${ARCH}" = aarch64 ]; then
    make-aur-package --archlinux-pkg rocksndiamonds-data
    make-aur-package --archlinux-pkg rocksndiamonds
else
    pacman -S --noconfirm rocksndiamonds
fi
