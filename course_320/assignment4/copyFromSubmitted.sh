#!/bin/bash
sourceFolder="submitted"

# copy header files
cmdCopyHFiles=`find $sourceFolder | grep "\.h$" | sed 's/^/cp /g' | sed 's/$/ ./g'`
#echo "$cmdCopyHFiles"
#exit
echo "$cmdCopyHFiles" | sh
dos2unix *.h

# copy source files
cppFiles=`find $sourceFolder | grep "\.cpp$"`
#echo "$cppFiles"
# net ids
netids=`echo "$cppFiles" | sed 's/.*_//g' | sed 's/\.cpp$//g'`
#echo "$netids"
# target files
targetFiles=`echo "$cppFiles" | sed 's/.*\///g'`
#echo "$targetFiles"
#exit
# repair command
cmdRepair=`echo "$netids" | sed 's/^/sed @s\/.*include.*umble.*\/#include \"jumble_/g' | sed 's/$/.h\"\/g@/g' | sed "s/@/'/g"`
#echo "$cmdRepair"
#exit
# command to copy and repair source files
cmdCopyAndRepairCppFiles=`paste -d @ <(echo "$cmdRepair") <(echo "$cppFiles") <(echo "$targetFiles") | sed 's/@/ /' | sed 's/@/ > /g'`
#echo "$cmdCopyAndRepairCppFiles"
#exit

echo "$cmdCopyAndRepairCppFiles" | sh
dos2unix *.cpp

