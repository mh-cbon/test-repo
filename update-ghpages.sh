#!/bin/bash

# GH='mh-cbon/test-repo'
# JEKYLL="pietromenna/jekyll-cayman-theme"

gem -v
jekyll -v

REPOPATH=`pwd`

cp config.jekyll.sh ~

if [ `git symbolic-ref --short -q HEAD | egrep 'gh-pages$'` ]; then
  echo "already on gh-pages"
else
  if [ `git branch -a | egrep 'remotes/origin/gh-pages$'` ]; then
    # gh-pages already exist on remote
    git checkout gh-pages
  else
    git checkout -b gh-pages
    find . -maxdepth 1 -mindepth 1 -not -name .git -exec rm -rf {} \;
    git commit -am "clean up"
  fi
fi

cd ~

rm -fr jekyll
git clone https://github.com/${JEKYLL}.git jekyll
cd ~/jekyll
ls -alh
rm -fr _posts/*

cp /${REPOPATH}/README.md index.md
echo "---" | cat - index.md > /tmp/out && mv /tmp/out index.md
echo "---" | cat - index.md > /tmp/out && mv /tmp/out index.md

sh ~/config.jekyll.sh

bundle install

jekyll build
jekyll serve --host=0.0.0.0
