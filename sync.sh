#!/bin/sh

src=$HOME/Library/ApplicationSupport/Code/User/
dest=$(dirname $0)/vscode/

# sync local change
echo cp $src/*.json $dest
cp $src/*.json $dest 
git commit $dest -m 'update vscode settings.json'
# merge remote change
git pull --ff-only
echo cp $dest/*.json $src
cp $dest/*.json $src
git push
echo "sync done."
