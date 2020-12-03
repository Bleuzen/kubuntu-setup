#!/bin/bash

if [[ $EUID -eq 0 ]];
then
    echo "Do not run this as root"
    exit
fi

echo "To apply the changes, you will be logged out. Save all of your work now!"
read -p "Press enter to continue..."


### SHELL ###

if [[ "$CHANGE_SHELL" == 1 ]]; then
    if [ -f "/home/$USER/.local/share/konsole/Shell.profile" ]; then
        kwriteconfig5 --file "/home/$USER/.local/share/konsole/Shell.profile" --group General --key Command --type string /usr/bin/fish
    fi
fi


### Global Shortcuts ###

# sed -i 's/Expose=Ctrl+F9/Expose=Meta+A\\tCtrl+F9/g' ~/.config/kglobalshortcutsrc


### KDE misc ###

kwriteconfig5 --file kcminputrc --group Keyboard --key NumLock --type int 0
kwriteconfig5 --file klipperrc --group General --key KeepClipboardContents --type bool false
kwriteconfig5 --file ksmserverrc --group General --key confirmLogout --type bool false
kwriteconfig5 --file ksmserverrc --group General --key loginMode --type string default
kwriteconfig5 --file ksmserverrc --group General --key offerShutdown --type bool true
kwriteconfig5 --file ksmserverrc --group General --key shutdownType --type int 0
kwriteconfig5 --file kwinrc --group NightColor --key Active --type bool true
kwriteconfig5 --file kwinrc --group MouseBindings --key CommandAllKey --type string Meta
kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key BorderSize --type string None
kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft --type string MF
kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight --type string IAX
kwriteconfig5 --file kwinrc --group Plugins --key CommandAllKey --type string Meta
kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled --type bool true
kwriteconfig5 --file kwinrc --group Plugins --key magiclampEnabled --type bool false
kwriteconfig5 --file kwinrc --group Plugins --key sheetEnabled --type bool true
# kwriteconfig5 --file kwinrc --group Plugins --key diminactiveEnabled --type bool true
kwriteconfig5 --file kwinrc --group Plugins --key kwin4_effect_dimscreenEnabled --type bool true
kwriteconfig5 --file kwinrc --group Plugins --key glideEnabled --type bool true && kwriteconfig5 --file kwinrc --group Plugins --key kwin4_effect_fadeEnabled --type bool false
kwriteconfig5 --file breezerc --group Windeco --key DrawTitleBarSeparator --type bool false
kwriteconfig5 --file breezerc --group Windeco --key TitleAlignment --type string AlignLeft


### Logout without confirmation ###

qdbus org.kde.ksmserver /KSMServer logout 0 3 3
