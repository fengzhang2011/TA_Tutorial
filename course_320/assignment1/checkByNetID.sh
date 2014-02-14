#!/bin/bash

# Runs the compilation and checks the results of a list of netids

if [[ $# -lt 1 ]]; then
    echo "Syntax: `basename $0` <netids>"
    exit 1
fi

for netid in $@; do
    if ./checkCompile.sh $netid; then
        echo "Compilation Successful"
        if ./checkResult.sh $netid; then
            echo "Passed testing"
        else
            echo "WARNING: Failed testing"
        fi
    else
        echo "WARNING: Program did not compile"
    fi
done
