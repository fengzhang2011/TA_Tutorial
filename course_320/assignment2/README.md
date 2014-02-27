The scripts are used to check the assignment2.

Usage
-----
	
	./checkByNetID.sh netid

Sample Results
--------------

	=============== netid: Compile ===============
	rm -f fraction_netid.o FractionTest.o
	rm -f *~ core *.core
	g++ -c -pipe -std=c++0x -O2 -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_SHARED -I/opt/QtSDK/Desktop/Qt/4.8.1/gcc/mkspecs/linux-g++ -I. -I/opt/QtSDK/Desktop/Qt/4.8.1/gcc/include/QtCore -I/opt/QtSDK/Desktop/Qt/4.8.1/gcc/include -I. -o fraction_netid.o fraction_netid.cpp
	fraction_netid.cpp:78: warning: unused parameter ‘dummy’
	g++ -c -pipe -std=c++0x -O2 -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_SHARED -I/opt/QtSDK/Desktop/Qt/4.8.1/gcc/mkspecs/linux-g++ -I. -I/opt/QtSDK/Desktop/Qt/4.8.1/gcc/include/QtCore -I/opt/QtSDK/Desktop/Qt/4.8.1/gcc/include -I. -o FractionTest.o FractionTest.cpp
	g++ -Wl,-O1 -Wl,-rpath,/opt/QtSDK/Desktop/Qt/4.8.1/gcc/lib -o assignment2 fraction_netid.o FractionTest.o    -L/opt/QtSDK/Desktop/Qt/4.8.1/gcc/lib -lQtCore -L/opt/QtSDK/Desktop/Qt/4.8.1/gcc/lib -lpthread
	=============== netid: Details ===============
	PASSED # Compilation passed.
	PASSED # singleCheck
	PASSED # Exception test
	PASSED # Sign test
	PASSED # Equality test
	PASSED # Inequality test
	PASSED # Greater then test
	PASSED # Less than test
	PASSED # Mixed type comparison test
	PASSED # Second mixed type comparison test
	FAILED # TESTCASE 1, due to 2144/3840 not 67/120
	PASSED # TESTCASE 2.
	FAILED # TESTCASE 3, due to -2/8 not -1/4
	FAILED # TESTCASE 4, due to 4/4 not 1/1
	FAILED # TESTCASE 5, due to -10/8 not -5/4
	FAILED # TESTCASE 6, due to 0/4 not 0/2
	=============== netid: Summary ===============
	netid: FAILED (pass:10 fail:5)
	===============================================
