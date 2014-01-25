# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit promptinit colors
compinit
promptinit
colors
source ~/.zsh/git-prompt/zshrc.sh
# End of lines added by compinstall
#
#PS1="${GREEN}%n@${ORANGE}%T %D ${BLUE}~ %# ${NORM}"
PROMPT='%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} %1~$(git_super_status)>'
RPROMPT="%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}[%?]%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%}"

source ~/config/alias
PATH=/opt/eclipse:$PATH:/sbin:/bin
source ~/.profile

source ~/projects/go/misc/zsh/go

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

# W. G. Scott ~/.zshrc
 
###########################################
#    X11 and $DISPLAY control             #
###########################################	

# Do this ONLY for OS X earlier than 10.5.  
	
# Now set the DISPLAY variable, if needed.  If X11.app is running,
# we deduce and construct the DISPLAY value from the process. If
# this doesn't work (no X11.app running), we give up and dumbly set the
# value to :0.0.  
		
if [[ -z $DISPLAY  && $(sw_vers -productVersion) < 10.5    && -z $SSH_CONNECTION && -o interactive ]]; then

    disp_no=($( ps -wwx | grep -F X11.app | awk '{print $NF}' | grep -e ":[0-9]"  ))

    if [[ -n $disp_no ]];then
        export DISPLAY=${disp_no}.0
		# Colorful output tells us that the smart method has worked
		print "\e[1mDISPLAY\e[0m \e[36mhas been set to\e[0m \e[1m$DISPLAY \e[0m"
    else
		# FAILSAFE: dumb setting of DISPLAY gives a monochromatic message
        export DISPLAY=:0.0
		print "DISPLAY has been set to $DISPLAY" 
    fi

fi

