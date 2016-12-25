#!/bin/bash

clear

free -m
Total_memory=$(free -m | grep Mem: | awk '{print $2}')
echo "Total Memory: " $Total_memory
Used_memory=$(free -m | grep Mem: | awk '{print $3}')
echo "Used_memory: " $Used_memory
Free_memory=$(free -m | grep Mem: | awk '{print $4}')
echo "Free Memory: " $Free_memory
