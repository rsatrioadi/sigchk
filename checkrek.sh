#!/bin/bash

while true
do
	echo move
	mv ../../Downloads/julrek/*.html 2020-07/rektor/
	echo rename
	rename 's/\.html$/\.pdf/' 2020-07/rektor/*.html
	echo check
	ruby sigcmpcsv.rb 2020-07/ref.csv 2020-07/rektor/*.pdf >> 2020-07/rektor/report.txt
	echo move
	mv 2020-07/rektor/*.pdf 2020-07/rektor/checked/
	echo sleep
	sleep 60
done
