#! /bin/bash
sed -i '' "/^\[localhost\]:60022.*$/d" $1
exit 0

