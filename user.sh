#!/bin/bash

if [[ $EUID -eq 0 ]];
then
    echo "Do not run this as root"
    exit
fi

echo "To apply the changes, you will be logged out. Save all of your work now!"
read -p "Press enter to continue..."



### ZSH ###

kwriteconfig5 --file "/home/$USER/.local/share/konsole/Default.profile" --group General --key Name --type string "Default"
kwriteconfig5 --file "/home/$USER/.local/share/konsole/Default.profile" --group General --key Command --type string /usr/bin/zsh

kwriteconfig5 --file "/home/$USER/.config/konsolerc" --group "Desktop Entry" --key "DefaultProfile" --type string "Default.profile"

cat > /home/$USER/.zshrc <<EOF
setopt histignorealldups sharehistory

bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "\$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u \$USER -o pid,%cpu,tty,cputime,cmd'

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^F' autosuggest-accept

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_DISABLE_RPROMPT=true

EOF



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
