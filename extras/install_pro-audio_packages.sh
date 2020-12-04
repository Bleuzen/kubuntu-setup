#!/bin/bash

if [[ $EUID -ne 0 ]];
then
    exec sudo /bin/bash "$0" "$@"
fi

function install_proaudio_packages {
    apt install -y studio-controls ardour lmms lsp-plugins x42-plugins geonkick drumkv1-lv2 synthv1-lv2 padthv1-lv2 zynaddsubfx zynaddsubfx-lv2 tap-plugins swh-plugins avldrums.lv2 caps calf-plugins dpf-plugins dragonfly-reverb eq10q guitarix mda-lv2
}

install_proaudio_packages
