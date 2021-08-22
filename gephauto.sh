#!/bin/bash

TK=$1

git clone https://madaraful:${TK}@github.com/madaraful/gephauto.git || exit

repodir=`pwd`

cd /tmp/ || exit
git clone https://github.com/geph-official/geph4.git || exit
cd geph4 || exit
cargo build --release --locked -j 20 || exit
cd target/release || exit
geph4bin=`pwd`/geph4-client
geph4ver=`$geph4bin --version|awk '{ print $2 }'`

cd $repodir || exit

dst=./geph4-client/${geph4ver}/
mkdir -p $dst || exit
echo DST IS $dst #debug
cd $dst || exit
cp $geph4bin ./geph4-client || exit
file /bin/bash > ./arch || exit

cd $repodir || exit

#exit 0

git config --global user.email "no@example.com" || exit
git config --global user.name "github actions commiter" || exit

git add -A || exit
git status || exit
git commit -m 'update' || exit
git push origin master || exit
