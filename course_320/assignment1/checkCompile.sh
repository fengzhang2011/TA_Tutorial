#!/bin/bash
netid=$1
echo "=============== $netid: Compile ==============="

#if [ `uname -s` = "Linux" ]
#	then
#		export LD_LIBRARY_PATH=/scratch3/fzhang/opt/lib:/scratch3/fzhang/tools/usr/lib:/scratch3/fzhang/tools/lib:/scratch3/fzhang/tools/usr/lib/i386-linux-gnu
#fi

generateTestFile ( ) {
	netid=$1
	`echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' TestInsultGenerator.cpp.orig > TestInsultGenerator.cpp`
}

generateMakeFile ( ) {
	netid=$1
	`echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' assignment1.pro.orig > assignment1.pro`
	`qmake assignment1.pro -r -spec linux-g++`
}

compile ( ) {
	netid=$1
	generateTestFile $netid
	generateMakeFile $netid
	make clean
	make
}

`rm -rf assignment1`
`rm -rf TestInsultGenerator.cpp`
`rm -rf SavedInsults.txt`
compile $netid

