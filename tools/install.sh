#! /bin/sh
BASE_URL=http://github.com/guileen/config/raw/master/
su root -c "wget $BASE_URL/tools/preinstall.sh && sh preinstall.sh && rm preinstall.sh"
git clone git://github.com/guileen/config.git ~/configs
# os rc
ln -s ~/configs/bashrc ~/.bashrc
ln -s ~/configs/zshrc ~/.zshrc
ln -s ~/configs/xinitrc ~/.xinitrc

# X config
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

# download aur packages
function mkaur {
    pkg=$1
    echo "downloading $pkg"
    /usr/bin/cower -df $pkg
    cd ~/configs/abs/$pkg
    makepkg -s --noconfirm
    sudo pacman -U --noconfirm *.pkg.tar.xz
}

pkgs=(cower-git nodejs-git libpci libpng12 google-chrome-dev)
for pkg in ${pkgs[@]}
do
    echo $pkg
    mkaur $pkg
done
