#!/bin/bash

while getopts ":a" opt; do
	case $opt in
		a)
			echo "-a was triggered!" >&2
			;;
		\?)
			echo "Invalid Option: -$OPTARG" >&2
			;;
	esac
done

