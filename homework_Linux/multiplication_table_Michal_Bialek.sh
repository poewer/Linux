#!/bin/bash

for ((i=1; i <= $1; i++));
do   
    for ((j=1; j <= $2; j++));
    do 
        count=$(($i * $j));
        echo "$i * $j = $count"
    done
done

#Tabliczka mnożenia