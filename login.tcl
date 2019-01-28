#! /usr/bin/expect

#
# Created by gavinguan on 2019/05/18 18:22:24.
# Copyright © 2019 gavinguan. All rights reserved.
#

# window

trap {
 set rows [stty rows]
 set cols [stty columns]
 stty rows $rows columns $cols < $spawn_out(slave,name)
} WINCH

# args

set _port 60022
set _addr root@localhost
set _password gavin
set timeout 1

# functions

proc do_ssh {} {
	spawn ssh -p $::_port $::_addr
	expect {
		"Host key verification failed." {
			exec bash -c {sed -i '' "/^\[localhost\]:60022.*$/d" ~/.ssh/known_hosts}
			puts "\[INFO\] Known_hosts changed. Restart me for Login."
			exit 
		}
		"password:" {
			send [append ::_password "\n"]
			interact 
		}
		"(yes/no)?" {
			send "yes\n"
			expect "password:" {
				send [append ::_password "\n"]
				interact
			}
		}
	}
}

######################## main

do_ssh
exit

