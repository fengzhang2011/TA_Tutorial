#!/bin/bash
netid=$1

output=`./$netid`

firstOriginal=`echo "$output" | head -n13 | tail -n 11`
#echo "$firstOriginal"

firstDiagonal=`echo "$firstOriginal" | awk 'BEGIN{i=0;} {split ($0, arr); if(i==0){printf("  ");} for(k=0;k<12;k++){if(i==0){if(k==2){printf(" ");}else{printf("");}} if(i>0 && k==i+1){printf(".  ");}else{printf("%s", arr[k]); if(k>1){printf("  ");}else{printf(" ");}}} printf("\n"); i++;}' | sed 's/ //g'`
#echo "$firstDiagonal"

unitTest11=`echo "$output" | head -n27 | tail -n 11`
#echo "$unitTest11"

unitTest12=`echo "$output" | head -n41 | tail -n 11 | sed 's/ //g'`
#echo "$unitTest12"

unitTest13=`echo "$output" | head -n55 | tail -n 11`
#echo "$unitTest13"

unitTest14=`echo "$output" | head -n69 | tail -n 11`
#echo "$unitTest14"

secondOriginal=`echo "$output" | head -n79 | tail -n 7`
#echo "$firstOriginal"

secondDiagonal=`echo "$secondOriginal" | awk 'BEGIN{i=0;} {split ($0, arr); if(i==0){printf("  ");} for(k=0;k<12;k++){if(i==0){if(k==2){printf(" ");}else{printf("");}} if(i>0 && k==i+1){printf("*  ");}else{printf("%s", arr[k]); if(k>1){printf("  ");}else{printf(" ");}}} printf("\n"); i++;}' | sed 's/ //g'`
#echo "$secondDiagonal"

unitTest21=`echo "$output" | head -n89 | tail -n 7`
#echo "$unitTest21"

unitTest22=`echo "$output" | head -n99 | tail -n 7 | sed 's/ //g'`
#echo "$unitTest22"

unitTest23=`echo "$output" | head -n109 | tail -n 7`
#echo "$unitTest23"

unitTest24=`echo "$output" | head -n119 | tail -n 7`
#echo "$unitTest24"

unitTest25=`echo "$output" | head -n129 | tail -n 7`
#echo "$unitTest25"

memoryLeakTest=`echo "$output" | head -n132 | tail -n 1`
#echo "$memoryLeakTest"

#cat haha1 | awk 'BEGIN{OFS="  "; i=0;}{if(i==0){print " ",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10;}else{print "@" $1 "@" $2,$3,$4,$5,$6,$7,$8,$9,$10,$11} i++;}' | sed 's/^@/ /g' | sed 's/@/ /g'
#cat haha1 | awk 'BEGIN{i=0;} {split ($0, arr); if(i==0){printf("  ");} for(k=0;k<12;k++){if(i==0){if(k==2){printf(" ");}else{printf("");}} if(i>0 && k==i+1){printf(".  ");}else{printf("%s", arr[k]); if(k>1){printf("  ");}else{printf(" ");}}} printf("\n"); i++;}'

# results of the unit test
ut11=`diff <(echo "$firstOriginal") <(echo "$unitTest11") | sed '/^$/d' | wc -l`
ut12=`diff <(echo "$firstDiagonal") <(echo "$unitTest12") | sed '/^$/d' | wc -l`
ut13=`diff <(echo "$firstOriginal") <(echo "$unitTest13") | sed '/^$/d' | wc -l`
ut14=`diff <(echo "$firstOriginal") <(echo "$unitTest14") | sed '/^$/d' | wc -l`
ut21=`diff <(echo "$secondOriginal") <(echo "$unitTest21") | sed '/^$/d' | wc -l`
ut22=`diff <(echo "$secondDiagonal") <(echo "$unitTest22") | sed '/^$/d' | wc -l`
ut23=`diff <(echo "$secondOriginal") <(echo "$unitTest23") | sed '/^$/d' | wc -l`
ut24=`diff <(echo "$secondOriginal") <(echo "$unitTest24") | sed '/^$/d' | wc -l`
ut25=`diff <(echo "$secondOriginal") <(echo "$unitTest25") | sed '/^$/d' | wc -l`
mt=`echo "$memoryLeakTest" | sed '/Passed/d' | wc -l`

echo "All tests passed, except:"
if [ $ut11 -eq "1" ];then echo "Unit test (11) failed."; fi
if [ $ut12 -eq "1" ];then echo "Unit test (12) failed."; fi
if [ $ut13 -eq "1" ];then echo "Unit test (13) failed."; fi
if [ $ut14 -eq "1" ];then echo "Unit test (14) failed."; fi
if [ $ut21 -eq "1" ];then echo "Unit test (21) failed."; fi
if [ $ut22 -eq "1" ];then echo "Unit test (22) failed."; fi
if [ $ut23 -eq "1" ];then echo "Unit test (23) failed."; fi
if [ $ut24 -eq "1" ];then echo "Unit test (24) failed."; fi
if [ $ut25 -eq "1" ];then echo "Unit test (25) failed."; fi
if [ $mt -eq "1" ];then echo "Unit test (memory test) failed."; fi

