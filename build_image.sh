#! /bin/bash

g_version=$1

docker build -t gavin:pure-vim_$g_version .

exit 0
