# PATH not support in fish
if [[ $SHELL != *"fish" ]]; then
	export PATH=~/.config/bin:~/go/bin:$PATH
fi

export JAVA_HOME="$(/usr/libexec/java_home)"

export EDITOR="vim"

alias ls='ls -G'
alias ll='ls -l -S -h'
