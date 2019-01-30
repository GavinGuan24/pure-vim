#! /bin/bash

if [[ $1 == 'start' ]]; then
	echo 'Init YCM with Java completer ...'
	cd ~/.vim/plugged/youcompleteme/
	git submodule update --init --recursive
	pip3 install future
	python3 ./install.py --java-completer
else
	echo -e "#################################################\n#\tThis script just do one thing.\t\t#\n#\tInit YCM with Java completer.\t\t#\n#\tIf you get it, just call me.\t\t#\n#\t aide_youcompleteme.sh start \t\t#"
fi
exit 0
