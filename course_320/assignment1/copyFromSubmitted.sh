#!/bin/bash
sourceFolder="submitted"

sourceFileList=`find $sourceFolder | grep "\.\(cpp\|h\)$" | sed '/TestInsultGenerator/d'`
destinationFileList=`echo "$sourceFileList" | sed 's/.*\///g' | tr '[:upper:]' '[:lower:]' | sed 's/_\([a-zA-Z0-9]\+\)_\(insultgenerator\)\./_\2_\1\./g' | sed 's/.*_insultgenerator_/insultgenerator_/g'`
#echo "$sourceFileList" | wc -l
#echo "$sourceFileList"
#echo "$destinationFileList" | wc -l
#echo "$destinationFileList"
#exit

copyCommand=`paste -d @ <(echo "$sourceFileList") <(echo "$destinationFileList") | sed 's/\s\+/ /g' | sed 's/^/cp "/g' | sed 's/@/" /g'`

#echo "$copyCommand"
echo "$copyCommand" | sh
#exit

#repair header file name
cppFileList=`ls insultgenerator_*.cpp`
for cppFile in $cppFileList
do
	#echo "cppFile: $cppFile"
	awk '{if(/include.*[Ii]nsult/){a=FILENAME; gsub(".cpp", ".h", a); printf("#include \"%s\"\n", a);}else {print $0;}}' $cppFile > $cppFile.tmp && mv $cppFile.tmp $cppFile
	dos2unix $cppFile > /dev/null 2>&1
done
