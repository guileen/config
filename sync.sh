#!/bin/sh

src="$HOME/Library/ApplicationSupport/Code/User/settings.json"
dest=$(dirname $0)/vscode/settings.json

# sync local change
echo cp $src $dest
cp $src $dest 
git commit $dest -m 'update vscode settings.json'
# merge remote change
git pull --ff-only
echo cp $dest $src
cp $dest $src
git push
echo "sync done."
