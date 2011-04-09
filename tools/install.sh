#! /bin/sh
REPO_PKGS="git sudo vim tmux zsh ibus rxvt-unicode pidgin zathura cmus antiword"
AUR_PKGS=(nodejs-git libpci libpng12 google-chrome-dev)
TARGET_DIR=/tmp/abs
F_ARG="-f"
PAC_F_ARG="--noconfirm"
COWER="`which cower`"

echo '********************'
echo '* install packages *'
echo '********************'
su -c "$PAC -Sy --noconfirm --needed $REPO_PKGS"

if [ ! -f "`which cower`" ] 
then
echo '*****************'
echo '* install cower *'
echo '*****************'
    mkdir -p $TARGET_DIR/cower-git
    cd $TARGET_DIR/cower-git
    wget http://aur.archlinux.org/packages/cower-git/PKGBUILD
    makepkg -ics $PAC_F_ARG
    COWER=/usr/bin/cower
fi

echo "cower is <$COWER>"

echo '************************'
echo '* install aur packages *'
echo '************************'

# download aur packages
function cowerSy {
    pkg=$1
    echo '******************************'
    echo "   install $pkg"
    echo '******************************'
    $COWER -d $F_ARG -t $TARGET_DIR $pkg
    cd $TARGET_DIR/$pkg
    makepkg -is $PAC_F_ARG
}

for pkg in ${AUR_PKGS[@]}
do
    cowerSy $pkg
done

echo '**********************************'
echo '* create symbol link for configs *'
echo '**********************************'
git clone git://github.com/guileen/config.git ~/configs
# sh rc
ln -s ~/configs/bashrc ~/.bashrc
ln -s ~/configs/zshrc ~/.zshrc

# X config
ln -s ~/configs/xinitrc ~/.xinitrc
ln -s ~/configs/Xmodmap ~/.Xmodmap
ln -s ~/configs/Xdefaults ~/.Xdefaults

# vimperator
ln -s ~/configs/vimperatorrc ~/.vimperatorrc
ln -s ~/configs/vimperatorrc ~/.pentadactylrc

# version control
ln -s ~/configs/hgrc ~/.hgrc
ln -s ~/configs/gitconfig ~/.gitconfig
ln -s ~/configs/gitignore ~/.gitignore

# vim
ln -s ~/configs/vimrc ~/.vimrc
ln -s ~/configs/vim ~/.vim
ln -s ~/configs/tools/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim

mkdir ~/.config
# awesome
ln -s ~/configs/awesome ~/.config/awesome

# cower
ln -s ~/configs/cower ~/.config/cower
