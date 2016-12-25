#!/bin/bash

clear

free
Total_memory=$(free | grep Mem: | awk '{print $2}')
echo $Total_memory
