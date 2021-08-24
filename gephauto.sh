#!/bin/bash

homedir=`mktemp -d`
cd $homedir || exit

TK=$1

git config --global user.email "no@example.com" || exit
git config --global user.name "GithubActionsCommiter" || exit

git clone https://madaraful:${TK}@github.com/madaraful/gephauto.git || exit
cd gephauto/ || exit
repodir=`pwd`

_build(){
  reponame=$1
  name=$2
  subdir=$3

  builddir=`mktemp -d`
  cd $builddir || exit

  git clone https://github.com/geph-official/${reponame} || exit
  cd $reponame || exit
  cd $subdir || exit

  cargo build --release --locked -j 20 || exit
  cd target/release || exit

  bin=`pwd`/${name}
  echo $bin
}
build(){
  _build $* &
}

clientbin=`build geph4 geph4-client ./geph4-client/`
wait

cp $clientbin $repodir


#exit 0

git add -A || exit
git status || exit
git commit -m 'update' || exit
git push origin master || exit
