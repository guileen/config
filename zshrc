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
# End of lines added by compinstall
#
#PS1="${GREEN}%n@${ORANGE}%T %D ${BLUE}~ %# ${NORM}"
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} %1~>"
RPROMPT="%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}[%?]%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%}"

source ~/config/alias
PATH=/opt/eclipse:$PATH
source ~/.profile

source ~/projects/go/misc/zsh/go

EDITOR=vim

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


###########################################
#   iTerm Tab and Title Customization     #
###########################################

function set_title_tab {

    function settab   {
	
		    # file settab  -- invoked only if iTerm or Konsole is running 

		    #  Set iterm window tab to current directory and penultimate directory if the
		    #  shell process is running.  Truncate to leave the rightmost $rlength characters.
		    #
		    #  Use with functions settitle (to set iterm title bar to current directory)
		    #  and chpwd


		if [[ $TERM_PROGRAM == iTerm.app && -z "$KONSOLE_DCOP_SESSION" ]];then

			# The $rlength variable prints only the 20 rightmost characters. Otherwise iTerm truncates
			# what appears in the tab from the left.
	     

				# Chage the following to change the string that actually appears in the tab:

					tab_label="$PWD:h:t/$PWD:t"

					rlength="20"   # number of characters to appear before truncation from the left

		            echo -ne "\e]1;${(l:rlength:)tab_label}\a"
	     

		else  

				# For KDE konsole tabs 

				# Chage the following to change the string that actually appears in the tab:

					tab_label="$PWD:h:t/$PWD:t"

					rlength="20"   # number of characters to appear before truncation from the left

		        # If we have a functioning KDE console, set the tab in the same way
		        if [[ -n "$KONSOLE_DCOP_SESSION" && ( -x $(which dcop)  )  ]];then
		                dcop "$KONSOLE_DCOP_SESSION" renameSession "${(l:rlength:)tab_label}"
		        else
		            : # do nothing if tabs don't exist
		        fi    
	
		fi
	}

    function settitle   {
		# Function "settitle"  --  set the title of the iterm title bar. use with chpwd and settab

		# Change the following string to change what appears in the Title Bar label:


			title_lab=$HOST:r:r::$PWD  
				# Prints the host name, two colons, absolute path for current directory

			# Change the title bar label dynamically:

			echo -ne "\e]2;[zsh]   $title_lab\a"
	}

	# Set tab and title bar dynamically using above-defined functions

		function title_tab_chpwd { settab ; settitle }
		
		# Now we need to run it:
	    title_tab_chpwd

	# Set tab or title bar label transiently to the currently running command
	
	if [[ "$TERM_PROGRAM" == "iTerm.app" ]];then		
		function title_tab_preexec {  echo -ne "\e]1; $(history $HISTCMD | cut -b7- ) \a"  } 
		function title_tab_precmd  { settab }	
	else
		function title_tab_preexec {  echo -ne "\e]2; $(history $HISTCMD | cut -b7- ) \a"  } 
		function title_tab_precmd  { settitle }      
	fi

 
	typeset -ga preexec_functions
	preexec_functions+=title_tab_preexec

	typeset -ga precmd_functions
	precmd_functions+=title_tab_precmd

	typeset -ga chpwd_functions
	chpwd_functions+=title_tab_chpwd
 
}

####################

set_title_tab
 





###########################################
#   other stuff                           #
###########################################
 

# Key bindings

bindkey '^L' push-input 
bindkey '\e[A'  history-search-backward 
bindkey '\e[B'  history-search-forward

# Some local aliases I like


    # alias ls='ls -hF'
    alias aptup="sudo apt-get update; sudo apt-get dist-upgrade"
    alias tar='nocorrect /usr/bin/tar'
    alias sudo='nocorrect sudo'
    alias scp="scp -C"


# Keeps the paths from growing too big
    
	typeset -U path manpath fpath



# Other zsh settings
    zmodload -i zsh/complist
    zstyle ':completion:*' menu select=10
    zstyle ':completion:*' verbose yes
    setopt hist_ignore_all_dups
 
 

# Make sure ~/.zlogin is always read if it exists

if [[ -f ~/.zlogin ]];then
    source ~/.zlogin
fi




# Force 'sudo zsh' to start root as a loging shell to 
# avoid problems with environment clashes:
function sudo {
	if [[ $1 = "zsh" ]]; then
        command sudo /bin/zsh -l
	else
        command sudo "$@"
	fi
}
