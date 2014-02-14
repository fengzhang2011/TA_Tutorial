#!/bin/bash

appDir="tmp" # Application directory
resultsDir="results" #Results directory
rootDir=`pwd` # Current directory - leave this alone

if [[ $# -lt 1 ]]; then
    echo "Syntax: `basename $0` <netid>"
    exit 1
fi

netid=$1

run ( ) {
    # Expect exception
    rm -f InsultsSource.txt
    ./assignment1

    # Expect no exception
    cp $rootDir/InsultsSource.txt.orig InsultsSource.txt
    ./assignment1
}

check ( ) {
    run > .tmp_assignment_result 2>&1
    result=`cat .tmp_assignment_result`
    #rm -r .tmp_assignment_result

    sourceInsult_1stCol=`sed 's/\s\+/,/g' InsultsSource.txt | cut -d , -f 1`
    sourceInsult_2ndCol=`sed 's/\s\+/,/g' InsultsSource.txt | cut -d , -f 2`
    sourceInsult_3rdCol=`sed 's/\s\+/,/g' InsultsSource.txt | cut -d , -f 3`
    #echo "$sourceInsult_1stCol" | wc -l
    #echo "$sourceInsult_2ndCol" | wc -l
    #echo "$sourceInsult_3rdCol" | wc -l

    # check results
    # first line must contain: FileException:xxx
    fileException=`echo "$result" | head -n 1`
    ret_fileException=`echo $fileException | wc -l`
    echo "$ret_fileException # $fileException"
    
    # must have NumInsultsOutOfBounds Exception
    NumInsultsOutOfBounds100=`echo "$result" | grep "NumInsultsOutOfBounds:100:"`
    ret_NumInsultsOutOfBounds100=`echo $NumInsultsOutOfBounds100 | wc -l`
    echo "$ret_NumInsultsOutOfBounds100 # $NumInsultsOutOfBounds100"
    
    NumInsultsOutOfBounds40000=`echo "$result" | grep -c "NumInsultsOutOfBounds:40000:"`
    if [[ $NumInsultsOutOfBounds40000 -eq 2 ]]; then
        ret_NumInsultsOutOfBounds40000=1
    else
        ret_NumInsultsOutOfBounds40000=0
    fi
    echo "$ret_NumInsultsOutOfBounds40000 # Found $NumInsultsOutOfBounds40000/2 errors"
    
    # the single insult must have three words splitted by tab
    singleInsult=`echo "$result" | grep "A single insult:" | sed 's/A single insult:Thou\s\+\(.*\)!/\1/g'`
    echo "singleInsult: $singleInsult"
    singleInsult_1stCol=`echo "$singleInsult" | sed 's/\s\+/,/g' | cut -d , -f 1`
    singleInsult_2ndCol=`echo "$singleInsult" | sed 's/\s\+/,/g' | cut -d , -f 2`
    singleInsult_3rdCol=`echo "$singleInsult" | sed 's/\s\+/,/g' | cut -d , -f 3`
    ret_1stCol=`echo "$sourceInsult_1stCol" | grep "^$singleInsult_1stCol$" | wc -l`
    ret_2ndCol=`echo "$sourceInsult_2ndCol" | grep "^$singleInsult_2ndCol$" | wc -l`
    ret_3rdCol=`echo "$sourceInsult_3rdCol" | grep "^$singleInsult_3rdCol$" | wc -l`
    echo "$ret_1stCol # 1stCol: $singleInsult_1stCol"
    echo "$ret_2ndCol # 2ndCol: $singleInsult_2ndCol"
    echo "$ret_3rdCol # 3rdCol: $singleInsult_3rdCol"

    # check output file: unique
    nbTotalLines=`cat SavedInsults.txt | wc -l`
    ret_size="1"
    if [ $nbTotalLines -ne "1000" ]
    then
        ret_size="0"
    fi
    echo "$ret_size # SizeCheck: total generate lines: $nbTotalLines (should be 1000)"
    nbUniqueLines=`sort SavedInsults.txt | uniq | wc -l`
    ret_unique=`echo "$nbTotalLines" | grep "^$nbUniqueLines$" | wc -l`
    echo "$ret_unique # UniqueCheck: $nbUniqueLines uniques and $nbTotalLines total"
    # check output file: sort
    diff_sort=`diff <(cat SavedInsults.txt) <(sort SavedInsults.txt)`
    ret_sort0=`echo "$diff_sort" | wc -l`
    ret_sort=`[ $ret_sort0 -eq "1" ] && echo "1" || echo "0"`
    echo "$ret_sort # SortCheck"
}

cd $appDir

checkResult=`check`

cd $rootDir

nbPassed=`echo "$checkResult" | grep "1 # " | wc -l`
nbFailed=`echo "$checkResult" | grep "0 # " | wc -l`

mkdir -p $resultsDir

echo "=============== $netid: Summary ===============" > $resultsDir/$netid
if [ $nbFailed -eq "0" ]; then
    echo "$netid: PASSED ($nbPassed)" >> $resultsDir/$netid
    ret=0
else
    echo "$netid: FAILED (pass:$nbPassed fail:$nbFailed)" >> $resultsDir/$netid
    ret=1
fi

echo "=============== $netid: Details ===============" >> $resultsDir/$netid
echo "$checkResult" >> $resultsDir/$netid

exit $ret
