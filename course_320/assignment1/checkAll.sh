#!/bin/bash

# Compiles and checks all netids

fileDir="processed"

netids=`ls $fileDir/insultgenerator_*.h | sed 's/.*insultgenerator_\(.*\).h/\1/g'`
for netid in $netids; do
    ./checkByNetID.sh $netid
done
