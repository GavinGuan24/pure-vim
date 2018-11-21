#! /bin/bash

g_version=$1

mkdir -p ~/Desktop/temp/testvim_$g_version/

docker run -itd --name testvim_$g_version -v ~/Desktop/temp/testvim_$g_version/:/root/testvim gavin:pure-vim_$g_version

exit 0
