#!/bin/bash

homedir=/tmp/aishwiwhskfiebaud/

mkdir -p $homedir || exit
cd $homedir || exit

TK=$1

git config --global user.email "no@example.com" || exit
git config --global user.name "GithubActionsCommiter" || exit

git clone https://madaraful:${TK}@github.com/madaraful/gephauto.git || exit
cd gephauto/ || exit
repodir=`pwd`

cd $homedir
git clone https://github.com/geph-official/geph4.git || exit
cd geph4 || exit
cargo build --release --locked -j 20 || exit
cd target/release || exit
geph4bin=`pwd`/geph4-client

cd $repodir || exit
cp $geph4bin ./geph4-client || exit

#exit 0

git add -A || exit
git status || exit
git commit -m 'update' || exit
git push origin master || exit
