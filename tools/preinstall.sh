#! env sh
USER=$1
#if no user return error
PAC="pacman --noconfirm"
$PAC -Syu
$PAC -Sy git sudo vim tmux zsh ibus rxvt-unicode pidgin zathura cmus antiword
