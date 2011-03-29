# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gl/.zshrc'

autoload -Uz compinit promptinit colors
compinit
promptinit
colors
# End of lines added by compinstall
#
#PS1="${GREEN}%n@${ORANGE}%T %D ${BLUE}~ %# ${NORM}"

PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}>"
RPROMPT="%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}[%?]%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%}"

source ~/configs/alias
PATH=/opt/eclipse:$PATH

EDITOR=vim
