#!/bin/bash

if [[ $EUID -ne 0 ]];
then
    exec sudo /bin/bash "$0" "$@"
fi

function disable_data_collection {
    apt remove -y ubuntu-report
}

function ban_snap {
    apt purge -y snapd
    rm -vrf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd
    bash -c 'cat << EOF > /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF'
}

function update_system {
    apt update && apt upgrade -y
}

function install_german_language_packs {
    apt install -y language-pack-de language-pack-gnome-de
    apt install -y $(check-language-support de)
}

function autoinstall_drivers {
    ubuntu-drivers install
}

function install_flatpak {
    apt install -y flatpak plasma-discover-backend-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function install_fish_shell {
    apt install -y fish
}

function install_zsh_shell {
    apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting zsh-theme-powerlevel9k
}

function install_themes {
    apt install -y materia-kde materia-gtk-theme papirus-icon-theme
}

disable_data_collection
ban_snap
update_system
install_german_language_packs
autoinstall_drivers
install_flatpak
# install_fish_shell
install_zsh_shell
install_themes
