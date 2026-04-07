#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm rocksndiamonds-contrib

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

if [ "${ARCH}" = x86_64 ]; then
    pacman -S --noconfirm rocksndiamonds
else
    make-aur-package --archlinux-pkg rocksndiamonds-data 
    make-aur-package --archlinux-pkg rocksndiamonds
fi
