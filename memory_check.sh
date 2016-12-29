\#!/bin/bash
clear

Total_memory=$(free -m | grep Mem: | awk '{print $2}')
Used_memory=$(free -m | grep Mem: | awk '{print $3}')
Free_memory=$(free -m | grep Mem: | awk '{print $4}')

while getopts ":c: :w: :e:" opt; do
	case $opt in
		c) 
			critical_threshold=${OPTARG}
			#echo "Critical Threshold (%) =" $critical_threshold
			let "critical_threshold = ($Total_memory * $critical_threshold / 100)"		
			;;
			
		w)

			warning_threshold=${OPTARG}
			#echo "Warning Threshold (%) =" $warning_threshold
			let "warning_threshold = ($Total_memory * $warning_threshold / 100)"
			
			;;

		e)
			email_address=${OPTARG}
			#echo "Entered email address: " $email_address
			;;

		\?)
			echo "Invalid option: -$OPTARG" >&2
			;;

		:)
			echo "Supply the following arguments"
			echo "-c Critical Threshold"
			echo "-w Warning Threshold"
			echo  "-e Email Address" >&2
			exit 1
			;;
	esac
done

if [ $critical_threshold -lt $warning_threshold ]
	then
		echo "Critical Threshold ($critical_threshold) MB should be greater than Warning Threshold ($warning_threshold) MB"
		exit 1
fi


if [ $Used_memory -ge $critical_threshold ]
	then
		dt=$(date '+%Y/%m/%d %H:%M');
		
		echo "Total System Memory: "$Total_memory "MB"
		echo "Used Memory: "$Used_memory "MB"
		echo "Critical Threshold: " $critical_threshold "MB"
		echo "Warning Threshold: " $warning_threshold "MB"
		echo "2. Used Memory ($Used_memory) is greater than or equal to critical threshold ($critical_threshold) mb."
		echo "Date: $dt"
		echo "Top 10 Processes: "
		ps -eo pid,%mem,user,args --sort -rss | head -10
		exit 1
fi

if [ $Used_memory -ge $warning_threshold ] && [ $Used_memory -lt $critical_threshold ]
	then
		
		echo "Total System Memory: "$Total_memory "MB"
		echo "Used Memory: "$Used_memory "MB"
		echo "Critical Threshold: " $critical_threshold "MB"
		echo "Warning Threshold: " $warning_threshold "MB"
		echo "1. Used Memory ($Used_memory) MB is greater than or equal to Warning threshold ($warning_threshold) MB but less than Critical threshold ($critical_threshold) MB"
		exit 1
fi

if [ $Used_memory -lt $warning_threshold ]
	then
		
		echo "Total System Memory: "$Total_memory "MB"
		echo "Used Memory: "$Used_memory "MB"
		echo "Critical Threshold: " $critical_threshold "MB"
		echo "Warning Threshold: " $warning_threshold "MB"
		echo "0: Used Memory ($Used_memory) MB is less than Warning threshold ($warning_threshold) MB"
fi
 

