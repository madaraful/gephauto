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

build(){
  repourl=$1
  name=$2

  cd $homedir || exit
  git clone https://github.com/geph-official/${reponame} || exit
  cd $reponame || exit
  cargo build --release --locked -j 20 || exit
  cd target/release || exit
  bin=`pwd`/${name}

  echo $bin
}

clientbin=`build geph4 geph4-client`

#exit 0

git add -A || exit
git status || exit
git commit -m 'update' || exit
git push origin master || exit
