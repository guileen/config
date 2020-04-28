#!/bin/sh

src="$HOME/Library/ApplicationSupport/Code/User/settings.json"
dest=$(dirname $0)/settings.json

# sync local change
cat $src
echo cp $src $dest
cp $src $dest 
git commit $dest -m 'update vscode settings.json'
# merge remote change
git pull
cp $dest $src
