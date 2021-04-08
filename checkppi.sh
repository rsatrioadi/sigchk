#!/bin/bash

while true
do
	echo move
	mv ../../Downloads/julppi/*.html 2020-07/ppi/
	echo rename
	rename 's/\.html$/\.pdf/' 2020-07/ppi/*.html
	echo check
	ruby sigcmpcsv.rb 2020-07/refppi.csv 2020-07/ppi/*.pdf >> 2020-07/ppi/report.txt
	echo move
	mv 2020-07/ppi/*.pdf 2020-07/ppi/checked/
	echo sleep
	sleep 60
done
