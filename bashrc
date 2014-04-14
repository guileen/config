
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -l -S -h'
alias pss='ps aux|grep'
alias vbox=VirtualBox
alias xp="VirtualBox --startvm XP &> /dev/null &"
alias vnc="vncviewer -FullColor=0 -LowColorLevel=2 192.168.1.110"
#PS1='[\u@\h \W]\$ '
PS1='\u \W>'
PATH=/opt/eclipse:/opt/google-appengine:~/config/bin:$PATH
PYTHONPATH=~/projects/clevercss3/:$PYTHONPATH
export HAXE_LIBRARY_PATH=/opt/haxe/std
export EDITOR=vim

source ~/config/alias
complete -cf sudo
source ~/config/bin/git-completion.bash
source ~/config/bin/hg_bash_completion
source ~/config/bin/bash_completion_tmux.sh
# source ~/toolkits/npm/npm-completion.sh
# . ~/config/bin/z.sh

function setproxy {
    export http_proxy=http://proxy.gxlu.com.cn:8888
    export https_proxy=http://proxy.gxlu.com.cn:8888
    export all_proxy=http://proxy.gxlu.com.cn:8888
}

