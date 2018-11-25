#! /bin/bash

target_folder=~/Desktop/temp/testvim_


g_version=$1

if [[ "$g_version" == "" ]]; then
	echo "The first parameter (version) cannot be empty, please enter something like this '0.0.1'"
	exit 0
fi

mkdir -p $target_folder$g_version/

docker run -itd --name purevim_$g_version -v $target_folder$g_version/:/root/purevim gavin:pure-vim_$g_version

exit 0
