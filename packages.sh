#!/bin/bash

# Define the packages you want to install
packages=(
  virtualbox
  virtualbox-guest-iso
  virtualbox-host-modules-arch
  clang
  cmake
  ninja
  gparted
  git
  audacious
  neofetch
  bleachbit
  cherrytree
  vlc
  bleachbit
  emacs
  jre17-openjdk
  jdk17-openjdk
  ufw
  gufw
  libreoffice-fresh
  nodejs
  npm
  onlyoffice-bin
  apparmor
  gnucash
  filelight
  vscodium-bin
  android-studio
)

# Check if yay is installed, if not, install it
if ! command -v yay > /dev/null 2>&1; then
  echo "yay not found. Installing yay..."
  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi

# Update package lists and upgrade system
sudo pacman -Syu --noconfirm

# Install packages
for package in "${packages[@]}"
do
  if pacman -Qs "$package" > /dev/null; then
    echo "Package $package is already installed. Skipping..."
  else
    if ! pacman -Si "$package" > /dev/null 2>&1; then
      echo "Unable to find package $package in main repository. Using yay instead."
      yay -S "$package" --noconfirm
    else
      echo "Installing package $package..."
      sudo pacman -S "$package" --noconfirm
    fi
  fi
done
