#!/bin/bash
netid=$1

checkCINTestCase ( ) {
	id=$1			# index of test case
	input=$2		# input formula of the test case
	expected=$3		# expected result of the formula
	expectedALT=$3	# alternative expected result of the formula
	ret=`echo -e "$input" | ./assignment2 | sed '/^$/d' | tail -n 1 | sed 's/.*Sum is: //g' | sed 's/"//g' | sed 's/\s//g'`
	bCheckResult=`diff <(echo "$ret") <(echo "$expected")`
	bCheckResultAlternative=`diff <(echo "$ret") <(echo "$expected")`
	if [ -z "$bCheckResult" ]
		then
			echo "PASSED # TESTCASE $id.";
	elif [ -z "$bCheckResultAlternative" ]
		then
			echo "PASSED # TESTCASE $id.";
	else
		formula=`echo -e "$input" | paste -s -d ,  | sed 's/,/ + /g'`
		echo "FAILED # TESTCASE $id ($formula): expected is ($expected), but actual is ($ret)";
	fi
}

checkAllCINTestCases ( ) {
	# test case 1: 1/2 3/-4 -5/-6 7/8 -9/10 0 => 67/120
	checkCINTestCase "1" "1/2\n3/-4\n-5/-6\n7/8\n-9/10\n0\n" "67/120" "67/120"
	# test case 2: 2 2/3 => 8/3
	checkCINTestCase "2" "2\n2/3\n0\n" "8/3" "8/3"
	# test case 3: 1/2 3/-4 => -1/4
	checkCINTestCase "3" "1/2\n3/-4\n0\n" "-1/4" "-1/4"
	# test case 4: 1/2 1/2 => 1/1
	checkCINTestCase "4" "1/2\n1/2\n0\n" "1/1" "1"
	# test case 5: -2/4 3/-4 => -5/4
	checkCINTestCase "5" "-2/4\n3/-4\n0\n" "-5/4" "-5/4"
	## test case 6: 1/-2 1/2 => 0/2
	#checkCINTestCase "6" "1/-2\n1/2\n0\n" "0/2" "0"
}

checkResult ( ) {
	`printf "0\n" | ./assignment2 > .tmp_assignment_result 2>&1`
	result=`cat .tmp_assignment_result`
	`rm -rf .tmp_assignment_result`

	# single check
	singleCheck=`echo "$result" | grep "Should be" | sed 's/^\(.*\):\s*Should be "\(.\+\)":\s\+\(.\+\)/\1,\2,\3/g' | sed 's/\s//g'`
	singleCheckResult=`diff <(echo "$singleCheck" | cut -d , -f 2) <(echo "$singleCheck" | cut -d , -f 3 | sed 's/["\s]//g')`
	diffInSingleCheck=`echo "$singleCheck" | sed 's/"//g' | awk -F , '$2!=$3 {print $1 " expected: " $2 " but acutal is: " $3;}'`;
	if [ -z "$singleCheckResult" ]
		then
			echo "PASSED # singleCheck";
	else
		echo "FAILED # singleCheck. Details:";
		echo "$diffInSingleCheck"
	fi

	# Exception check
	#Exception message should indicate illegal denominator: Denominator cannot be zero!
	ExceptionTestCheck=`echo "$result" | grep "Exception message should indicate illegal denominator:"`
	if [ -z "$ExceptionTestCheck" ]
		then
			echo "FAILED # Exception test";
	else
		echo "PASSED # Exception test";
	fi

	# sign check
	#Numerator should be -7: -7
	#Denominator should be 2: 2
	SignTestCheck=`echo "$result" | grep "\(Numerator\|Denominator\) should be " | sed 's/.*should be //g' | sed 's/: /,/g'`
	SignTestCheckResult=`diff <(echo "$SignTestCheck" | cut -d , -f 1) <(echo "$SignTestCheck" | cut -d , -f 2 | sed 's/["\s]//g')`
	if [ -z "$SignTestCheckResult" ]
		then
			echo "PASSED # Sign test";
	else
		echo "FAILED # Sign test";
	fi

	# comparison check
	EqualityTestCheck=`echo "$result" | grep "Equality test passed."`
	if [ -z "$EqualityTestCheck" ]
		then
			echo "FAILED # Equality test";
	else
		echo "PASSED # Equality test";
	fi
	InequalityTestCheck=`echo "$result" | grep "Inequality test passed."`
	if [ -z "$InequalityTestCheck" ]
		then
			echo "FAILED # Inequality test";
	else
		echo "PASSED # Inequality test";
	fi
	GreaterThanTestCheck=`echo "$result" | grep "Greater than test passed."`
	if [ -z "$GreaterThanTestCheck" ]
		then
			echo "FAILED # Greater than test";
	else
		echo "PASSED # Greater then test";
	fi
	LessThanTestCheck=`echo "$result" | grep "Less than test passed."`
	if [ -z "$LessThanTestCheck" ]
		then
			echo "FAILED # Less than test";
	else
		echo "PASSED # Less than test";
	fi
	MixedTypeTestCheck=`echo "$result" | grep "Mixed type comparison passed."`
	if [ -z "$MixedTypeTestCheck" ]
		then
			echo "FAILED # Mixed type comparison test";
	else
		echo "PASSED # Mixed type comparison test";
	fi
	SecondMixedTypeTestCheck=`echo "$result" | grep "Second mixed type comparison passed."`
	if [ -z "$SecondMixedTypeTestCheck" ]
		then
			echo "FAILED # Second mixed type comparison test";
	else
		echo "PASSED # Second mixed type comparison test";
	fi

	# test cases for cin
	checkAllCINTestCases
}

check ( ) {
	checkResult=`checkResult`

	nbPassed=`echo "$checkResult" | grep "PASSED # " | wc -l`
	nbFailed=`echo "$checkResult" | grep "FAILED # " | wc -l`

	echo "=============== $netid: Details ==============="
	echo "PASSED # Compilation passed.";
	echo "$checkResult"

	echo "=============== $netid: Summary ==============="
	if [ $nbFailed -eq "0" ]
		then
			echo "$netid: PASSED ($nbPassed)"
	else
		echo "$netid: FAILED (pass:$nbPassed fail:$nbFailed)"
	fi
	echo "==============================================="
}

checkAll ( ) {
	if [ -f ./assignment2 ]
		then
			check
	else
		echo "=============== $netid: Summary ==============="
		echo "$netid: FAILED (FATAL error: compilation failed)"
		echo "=============== $netid: Details ==============="
		echo "FAILED # Compilation failed.";
	fi
}

checkAll

