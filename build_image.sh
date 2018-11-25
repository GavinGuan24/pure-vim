#! /bin/bash

g_version=$1

if [[ "$g_version" == "" ]]; then
	echo "The first parameter (version) cannot be empty, please enter something like this '0.0.1'"
	exit 0
fi

docker build -t gavin:pure-vim_$g_version .

exit 0
