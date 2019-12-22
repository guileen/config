HISTSIZE=10000
SAVEHIST=10000
bindkey -v
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

#PS1="${GREEN}%n@${ORANGE}%T %D ${BLUE}~ %# ${NORM}"
RPROMPT="%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}[%?]%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%}"

source ~/.config/profile

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Anaconda my env
source activate python37

# AutoJump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

#zsh completions have been installed to:
#  /usr/local/share/zsh/site-functions
