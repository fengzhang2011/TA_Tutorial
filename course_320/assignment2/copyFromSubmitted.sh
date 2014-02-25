#!/bin/bash
sourceFolder="submitted"

sourceFileList=`find $sourceFolder | grep "\.\(cpp\|h\)$" | sed '/Test/d'`
destinationFileList=`echo "$sourceFileList" | sed 's/.*\///g' | tr '[:upper:]' '[:lower:]' | sed 's/function/fraction/g '| sed 's/.*\(fraction\)_*\(.\+\)\./\1_\2\./g' | sed 's/06349355/0ks18/g'`
#echo "$sourceFileList" | wc -l
#echo "$sourceFileList"
#echo "$destinationFileList" | wc -l
#echo "$destinationFileList"

copyCommand=`paste -d , <(echo "$sourceFileList") <(echo "$destinationFileList") | sed 's/,/" /g' | sed 's/^/cp "/g'`

echo "$copyCommand" | sh
#echo "$copyCommand"

#repair header file name
sourceCppFileList=`echo "$sourceFileList" | sed 's/.*\///g' | grep "cpp$"`
sourceHeaderFileList=`echo "$sourceFileList" | sed 's/.*\///g' | grep "h$"`
destinationCppFileList=`echo "$destinationFileList" | sed 's/.*\///g' | grep "cpp$"`
destinationHeaderFileList=`echo "$destinationFileList" | sed 's/.*\///g' | grep "h$"`
#echo "$sourceCppFileList"
#echo "$sourceHeaderFileList"

repairCommand=`paste -d , <(echo "$sourceHeaderFileList") <(echo "$destinationHeaderFileList") <(echo "$destinationCppFileList") | sed 's/^/sed -i "s\//g' | sed 's/,/\//' | sed 's/,/\/" /'`
#echo "$repairCommand"
#echo "$repairCommand" | sh

