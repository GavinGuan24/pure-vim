#! /bin/bash

target_folder=~/Desktop/temp/testvim_


g_version=$1

mkdir -p $target_folder$g_version/

docker run -itd --name purevim_$g_version -v $target_folder$g_version/:/root/purevim gavin:pure-vim_$g_version

exit 0
