#!/bin/sh

src="$HOME/Library/ApplicationSupport/Code/User/settings.json"
dest=$(dirname $0)/settings.json

# sync local change
echo cp $src $dest
cp $src $dest 
git commit $dest -m 'update vscode settings.json'
# merge remote change
git pull
echo cp $dest $src
cp $dest $src
git push
echo "sync done."
