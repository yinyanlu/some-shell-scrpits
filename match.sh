#!/bin/bash

inputa="$1"
inputb="$2"

while read linesa; do
	while read linesb; do
		if [ $linesa == $linesb ];then
			echo "$linesa is the same"
		fi
	done<$inputb
done < $inputa
