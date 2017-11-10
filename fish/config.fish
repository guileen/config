if not functions -q fundle; echo "install fundle"; eval (curl -sfL https://git.io/fundle-install); end
fundle plugin 'edc/bass'
fundle plugin 'jhillyerd/plugin-git'
# if fundle got slow
#fundle init --profile
fundle init


bass source ~/.profile

set -gx PATH $GOPATH/bin ~/anaconda2/bin ~/bin ~/config/bin ~/projects/go/bin /usr/local/bin /usr/local/sbin $ANDROID_SDK_ROOT/platform-tools $PATH /sbin ~/projects/mongodb/bin
set fish_greeting

#autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

function nvm
    bass source ~/.nvm/nvm.sh ';' nvm $argv
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function iterm2_print_user_vars
  set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')
  iterm2_set_user_var gitBranch "$git_branch"
  set -lx time (date '+%m-%d %H:%M')
  iterm2_set_user_var time "$time"
end
