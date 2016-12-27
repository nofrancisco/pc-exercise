\#!/bin/bash
clear
free
Total_memory=$(free -m | grep Mem: | awk '{print $2}')
echo "Total Memory: "$Total_memory "mb"
Used_memory=$(free -m | grep Mem: | awk '{print $3}')
echo "Used_memory: "$Used_memory "mb"
Free_memory=$(free -m | grep Mem: | awk '{print $4}')
echo "Free Memory: "$Free_memory "mb"

while getopts ":c: :w: :e:" opt; do
	case $opt in
		c) 
				
			critical_threshold=${OPTARG}
			echo "Critical Threshold (%) =" $critical_threshold
			critical_value=$(bc <<< "scale=2; $Total_memory - ($Total_memory * ($critical_threshold/100))")
			echo $critical_value
			
			;;
			
		w)
			warning_threshold=${OPTARG}
			echo "Warning Threshold (%) =" $warning_threshold
			warning_value=$(bc <<< "scale=2; $Total_memory - ($Total_memory * ($warning_threshold/100))")
			echo $warning_value
			;;

		e)
			email_address=${OPTARG}
			echo "Entered email address: " $email_address
			;;

		\?)
			echo "Invalid option: -$OPTARG" >&2
			;;

		:)
			echo "Supply Required Arguments" >&2
			exit 1
			;;
	esac
done


		 
		
