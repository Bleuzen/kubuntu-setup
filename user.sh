#!/bin/bash

if [[ $EUID -eq 0 ]];
then
    echo "Do not run this as root"
    exit
fi

echo "To apply the changes, you will be logged out. Save all of your work now!"
read -p "Press enter to continue..."


### Fish SHELL ###

# if [ -f "/home/$USER/.local/share/konsole/Profile 1.profile" ]; then
#     kwriteconfig5 --file "/home/$USER/.local/share/konsole/Profile 1.profile" --group General --key Command --type string /usr/bin/fish
# fi
# 
# mkdir -p /home/$USER/.config/fish
# 
# cat > /home/$USER/.config/fish/fish_variables <<EOF
# # This file contains fish universal variable definitions.
# # VERSION: 3.0
# SETUVAR __fish_initialized:3100
# SETUVAR fish_color_autosuggestion:555\x1ebrblack
# SETUVAR fish_color_cancel:\x2dr
# SETUVAR fish_color_command:005fd7
# SETUVAR fish_color_comment:990000
# SETUVAR fish_color_cwd:green
# SETUVAR fish_color_cwd_root:red
# SETUVAR fish_color_end:009900
# SETUVAR fish_color_error:ff0000
# SETUVAR fish_color_escape:00a6b2
# SETUVAR fish_color_history_current:\x2d\x2dbold
# SETUVAR fish_color_host:normal
# SETUVAR fish_color_host_remote:yellow
# SETUVAR fish_color_match:\x2d\x2dbackground\x3dbrblue
# SETUVAR fish_color_normal:normal
# SETUVAR fish_color_operator:00a6b2
# SETUVAR fish_color_param:00afff
# SETUVAR fish_color_quote:999900
# SETUVAR fish_color_redirection:00afff
# SETUVAR fish_color_search_match:bryellow\x1e\x2d\x2dbackground\x3dbrblack
# SETUVAR fish_color_selection:white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
# SETUVAR fish_color_status:red
# SETUVAR fish_color_user:brgreen
# SETUVAR fish_color_valid_path:\x2d\x2dunderline
# SETUVAR fish_greeting:\x1d
# SETUVAR fish_key_bindings:fish_default_key_bindings
# SETUVAR fish_pager_color_completion:\x1d
# SETUVAR fish_pager_color_description:B3A06D\x1eyellow
# SETUVAR fish_pager_color_prefix:white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
# SETUVAR fish_pager_color_progress:brwhite\x1e\x2d\x2dbackground\x3dcyan
# EOF
# 
# mkdir -p /home/$USER/.config/fish/functions
# 
# cat > /home/$USER/.config/fish/functions/fish_prompt.fish <<EOF
# function fish_prompt
#     if test -n "$SSH_TTY"
#         echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
#     end
# 
#     echo -n (set_color blue)(prompt_pwd)' '
# 
#     set_color -o
#     if test "$USER" = 'root'
#         echo -n (set_color red)'# '
#     end
#     echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
#     set_color normal
# end
# EOF


### ZSH ###

kwriteconfig5 --file "/home/$USER/.local/share/konsole/Default.profile" --group General --key Name --type string "Default"
kwriteconfig5 --file "/home/$USER/.local/share/konsole/Default.profile" --group General --key Command --type string /usr/bin/zsh

kwriteconfig5 --file "/home/$USER/.config/konsolerc" --group "Desktop Entry" --key "DefaultProfile" --type string "Default.profile"

cat > /home/$USER/.zshrc <<EOF

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "\$(dircolors -b)"
zstyle ':completion:*:default' list-colors \${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
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
