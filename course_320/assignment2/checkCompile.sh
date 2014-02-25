#!/bin/bash
netid=$1
echo "=============== $netid: Compile ==============="

generateTestFile ( ) {
	netid=$1
	`echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' FractionTest.cpp.orig > FractionTest.cpp`
}

generateMakeFile ( ) {
	netid=$1
	`echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' assignment2.pro.orig > assignment2.pro`
	`qmake assignment2.pro -r -spec linux-g++`
}

compile ( ) {
	netid=$1
	generateTestFile $netid
	generateMakeFile $netid
	make clean
	make
}

`rm -rf assignment2`
`rm -rf FractionTest.cpp`
`rm -rf SavedInsults.txt`
compile $netid


