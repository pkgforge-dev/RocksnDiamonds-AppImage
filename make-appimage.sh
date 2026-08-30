#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q rocksndiamonds | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/128x128/apps/rocksndiamonds.png
export DESKTOP=/usr/share/applications/rocksndiamonds.desktop
export STARTUPWMCLASS=rocksndiamonds
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/rocksndiamonds /usr/share/rocksndiamonds \
/usr/lib/libxmp.so* \
/usr/lib/libmodplug.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
