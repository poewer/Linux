#!/bin/bash

echo "Podaj wymiary tabliczki mnożenia A x B"
echo "Podaj A"
read A
echo "Podaj B"
read B

for ((i=1; i <= $A; i++));
do   
    for ((j=1; j <= $B; j++));
    do 
        nowa=$(($i * $j));
        echo "$i * $j = $nowa"
    done
done

