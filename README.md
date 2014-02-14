Assignment 1
============

copyFromSubmitted.sh
--------------------
Syntax: `copyFromSubmitted.sh`

Processes files in the `submitted` directory, standardizes the filenames, and copies them to the `processed` folder

checkCompile.sh
---------------
Syntax: `checkCompile.sh <netid>`

Makes a directory (`tmp`), copies <netid>s files into it, and attempts to compile the script for testing.

Will return a status code of 1 if the compilation failed, 0 if it succeeded.

checkResult.sh
--------------
Syntax: `checkResult.sh <netid>`

Must be called after `checkCompile.sh`.

Runs the testing programs, parses the output, and checks if all the conditions of the assignment are met.
A log of this result is saved to the `results` directory.

Will return a status code of 1 if the validation fails, 0 if it succeeds.

checkByNetID.sh
---------------
Syntax: `checkByNetID.sh <netids>`

Takes a list of netids and runs the `checkCompile.sh` and `checkResult.sh` scripts for them.

checkAll.sh
-----------
Syntax: `checkAll.sh`

Runs the `checkCompile.sh` and `checkResult.sh` scripts for every file in the `processed` directory.
