
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias pss='ps aux|grep'
alias vbox=VirtualBox
alias xp="VirtualBox --startvm XP &> /dev/null &"
alias vnc="vncviewer -FullColor=0 -LowColorLevel=2 192.168.1.110"
#PS1='[\u@\h \W]\$ '
PS1='\u \W>'
PATH=/opt/eclipse:/opt/google-appengine:/home/gl/bin:$PATH
PYTHONPATH=/home/gl/projects/clevercss3/:$PYTHONPATH
export HAXE_LIBRARY_PATH=/opt/haxe/std

complete -cf sudo
source /home/gl/projects/configs/git-completion.bash
export EDITOR=vim

source /home/gl/bin/hg_bash_completion
source /home/gl/bin/bash_completion_tmux.sh

function setproxy {
    export http_proxy=http://proxy.gxlu.com.cn:8888
    export https_proxy=http://proxy.gxlu.com.cn:8888
    export all_proxy=http://proxy.gxlu.com.cn:8888
}
