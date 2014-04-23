#!/bin/bash
netid=$1
echo "=============== $netid: Compile ==============="

generateTestFile ( ) {
	netid=$1
	`echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' testJumble.cpp.orig | sed 's/\/\/testJumble/testJumble/g' | sed 's/^\(\s\+\)playGame/\1\/\/playGame/g' > testJumble.cpp`
}

generateMakeFile ( ) {
	netid=$1
	`echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' assignment4.pro.orig > assignment4.pro`
	`qmake assignment4.pro -r -spec linux-g++`
}

compile ( ) {
	netid=$1
	generateTestFile $netid
	generateMakeFile $netid
	make clean
	make
}

`rm -rf netid`
`rm -rf testJumble.cpp`
compile $netid


