#!/bin/bash
sourceFolder="submitted"
destFolder="processed"

# Clear up old files (if any)
rm -rf $destFolder
mkdir $destFolder

# Get a list of all cpp and h files without the 'TestInsultGenerator' files
sourceFileList=`find $sourceFolder | grep "\.\(cpp\|h\)$" | sed '/testinsultgenerator/Id'` && IFS=$'\n'

for file in $sourceFileList
do
    destFile=$destFolder/`echo "$file" | sed "s/.*\(insultgenerator_[a-z0-9]\+\)\./\L\1\./ig"`

    # Copy each file to the $destfolder with a standardized name
    cp "$file" "$destFile"

    # Convert the line endings to UNIX-style
	dos2unix "$destFile" > /dev/null 2>&1

    # Fix the header file reference
    if [[ $destFile == *.cpp ]]
    then
        sed -i 's/^\s*\#include "insultgenerator_\([a-z0-9]\+\)\.h"\s*$/\L\#include "insultgenerator_\1.h"/i' $destFile
    fi
done
