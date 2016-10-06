#!/bin/sh

CURRENT_DIR=`pwd`
GIT_URL=`git config --get remote.origin.url`
TEMP_DEST=/tmp/termsuite.github.io.build
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
STAMP=`date "+%Y%m%d-%H%M%S"`
GIT_HASH=`git log --pretty=format:'%h' -n 1`


rm -rf $TEMP_DEST
mkdir $TEMP_DEST
git clone $GIT_URL $TEMP_DEST

bundle exec jekyll build JEKYLL_ENV=production --destination $TEMP_DEST

cd $TEMP_DEST

git add --all
git commit -m "Built by jekyll from branch $CURRENT_BRANCH ($GIT_HASH) at $STAMP"
git push origin master

cd $CURRENT_DIR

echo "done"
