#!/bin/bash

repodir=`pwd`

cd /tmp/ || exit
git clone https://github.com/geph-official/geph4.git || exit
cd geph4 || exit
cargo build --release --locked -j 20 || exit
cd target/release || exit
geph4bin = `pwd`/geph4-client

cd $repodir || exit

mkdir ./geph4-client
cp $geph4bin ./geph4-client || exit

ls -hl
