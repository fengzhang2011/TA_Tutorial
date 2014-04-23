#/bin/bash
netid=$1
target="fengzhang"

output=`echo -e "$target\nhard" | ./$netid`
puzzle=`echo "$output" | grep "^\s*[0-9]\+"`
solution=`echo "$output" | sed '/^\s*[0-9]/d' | tail -n2 | head -n1`

# find the solution
cleanedMatrix=`echo "$puzzle" | sed 's/\s*[0-9]\+\s\+//g' | sed 's/\s\+/,/g' | sed '/^$/d'`

# matrix in the direction of east
matrixDirectionEast=`echo "$cleanedMatrix" | sed 's/,//g'`
#echo "$matrixDirectionEast"

# matrix in the direction of west
matrixDirectionWest=`echo "$matrixDirectionEast" | rev`
#echo "$matrixDirectionWest"

# matrix in the direction of south
tempArray=()
nbSize=`echo "$cleanedMatrix" | wc -l`
for (( i=1; i<=$nbSize; i++ ))
	do
		columnText=`echo "$cleanedMatrix" | cut -d , -f $i | paste -s | sed 's/\s\+//g'`
		tempArray+=($columnText)
done
tempString=$(IFS=",";echo "${tempArray[*]}")
matrixDirectionSouth=`echo "$tempString" | sed 's/,/\n/g'`
#echo "$matrixDirectionSouth"

# matrix in the direction of north
matrixDirectionNorth=`echo "$matrixDirectionSouth" | rev`
#echo "$matrixDirectionNorth"

# function for finding solution
inputMatrix=""
row=""
col=""
function findIt ()
{
	matrix=$inputMatrix
	matchedText=`echo "$matrix" | grep -n "$target"`
	row=`echo "$matchedText" | sed 's/:.*//g'`
	[ ! -z $row ] && row=$(expr $row - 1 )
	#echo "row=$row"
	text=`echo "$matchedText" | sed 's/.*://g'`
	col=$(expr $(expr match "$text" ".*${target}") - $(expr length "$target"))
	#echo "col=$col"
}

#
# find solution
solutionRow=""
solutionCol=""
solutionDirection=""

lengthLine=$nbSize
#echo "lengthLine=$lengthLine"
lengthTarget=$(expr length "$target")
#echo "lengthTarget=$lengthTarget"

# 1. check the direction of east
inputMatrix=$matrixDirectionEast
findIt
if [ ! -z $row ]; then
	solutionRow=$row
	solutionCol=$col
	solutionDirection="East"
fi

# 2. check the direction of west
inputMatrix=$matrixDirectionWest
findIt
if [ ! -z $row ]; then
	solutionRow=$row
	solutionCol=$(expr $lengthLine - $col - 1)
	solutionDirection="West"
fi

# 3. check the direction of south
inputMatrix=$matrixDirectionSouth
findIt
if [ ! -z $row ]; then
	solutionRow=$col
	solutionCol=$row
	solutionDirection="South"
fi

# 4. check the direction of north
inputMatrix=$matrixDirectionNorth
findIt
if [ ! -z $row ]; then
	solutionRow=$(expr $lengthLine - $col - 1)
	solutionCol=$row
	solutionDirection="North"
fi

echo "================================================"
echo "$solution"
echo "================================================"
echo "++++++++++++++++++++++++++++++++++++++++++++++++"
echo "ROW: $solutionRow   COL: $solutionCol   Direction: $solutionDirection"
echo "++++++++++++++++++++++++++++++++++++++++++++++++"
