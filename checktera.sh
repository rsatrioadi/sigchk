#!/bin/bash

while true
do
	echo move
	mv ../../Downloads/okttera/*.html 2020-10/tera/
	echo rename
	rename 's/\.html$/\.pdf/' 2020-10/tera/*.html
	echo check
	ruby sigcmpcsv.rb 2020-10/reftera.csv 2020-10/tera/*.pdf >> 2020-10/tera/report.txt
	echo move
	mv 2020-10/tera/*.pdf 2020-10/tera/checked/
	echo sleep
	sleep 60
done
