# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit promptinit colors
compinit
promptinit
colors
# source ~/.zsh/git-prompt/zshrc.sh
# End of lines added by compinstall
#
#PS1="${GREEN}%n@${ORANGE}%T %D ${BLUE}~ %# ${NORM}"
#PROMPT='%B%{$fg[green]%}%n@%m%{$reset_color%} %B%{$fg[blue]%}%1~$(git_super_status)>%{$reset_color%}'
RPROMPT="%B%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}[%?]%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%}"
source ~/.profile

EDITOR=vim

fpath=(~/.zsh $fpath)

##################################################################
# Stuff to make my life easier

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

export NVM_DIR="/Users/gl/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

. /Users/gl/torch/install/bin/torch-activate

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

