if not functions -q fundle; echo "install fundle"; eval (curl -sfL https://git.io/fundle-install); end
#fundle plugin 'edc/bass'
fundle plugin 'jhillyerd/plugin-git'
# if fundle got slow
#fundle init --profile
fundle init

# bass is slow. use sed | source - instead.
#bass source ~/.config/profile

# https://stackoverflow.com/questions/29667714/convert-bash-function-to-fishs
function posix-source
    # gnu sed, brew install gnu-sed
    gsed -re 's/export (.*)=(.*)/set -x \1 \2/g' -e 's/^([^\s]*)=(.*)/set \1 \2/g' -e 's/\$\((.*)\)/(\1)/g' $argv[1] | source -
end
posix-source ~/.config/profile

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
  set -lx time (date '+%m-%d %H:%M:%S')
  iterm2_set_user_var time "$time"
  iterm2_set_user_var ppwd (prompt_pwd)
end
