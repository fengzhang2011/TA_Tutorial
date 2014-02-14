#!/bin/bash

# Compiles a program for a netid
# Returns 0 if the compilation was sucessful, 1 otherwise

fileDir="processed" # Get files from here
scratchDir="tmp" # Compilation directory
rootDir=`pwd` # Current directory - leave this alone

if [[ $# -lt 1 ]]; then
    echo "Syntax: `basename $0` <netid>"
    exit 1
fi

netid=$1

echo "=============== $netid: Compile ==============="

compile ( ) {

    # Go into the scratch directory
    cd $scratchDir

    # Copy in the source files
    cp $rootDir/$fileDir/insultgenerator_$netid.* .

    # Generate the compilation files
    echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' $rootDir/TestInsultGenerator.cpp.orig > TestInsultGenerator.cpp
    echo "$netid" | xargs -L1 -I {} sed 's/netid/{}/g' $rootDir/assignment1.pro.orig > assignment1.pro
    qmake assignment1.pro -r -spec linux-g++

    # Build the program
    ret=1
    if make >/dev/null; then
        ret=0
    fi

    # Back into the root directory
    cd $rootDir

    # Return the status code of the compilation
    return $ret;
}

# Clear up old files (if any)
rm -rf $scratchDir
mkdir -p $scratchDir

if ! compile $netid; then
    exit 1
else
    exit 0
fi
