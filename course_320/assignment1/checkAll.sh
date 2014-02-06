#!/bin/bash
netids=`ls insultgenerator_*.h | sed 's/insultgenerator_\(.*\).h/\1/g'`
for netid in $netids
	do
		./checkByNetID.sh $netid
done
