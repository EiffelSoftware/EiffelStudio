Testing scripts are located in Src/com_wizard/testing

Before starting test you need to modify 
config.eif line 20:
replace 
wkoptimize: "-Od -Zi"
by 
wkoptimize: -Zm300"

This would prevent C compiler from crashing during the
test. This only become a problem during testing of Office
type libraries because they are very very big and the 
generated code takes more than 1GB of hard drive space.

test.bat calls test_c.bat and test_s.bat
test_c.bat is a list of calls to test_client.bat with the first 
argument is a name of a directory and the second argument is the
full path to a type library. This file might need to be modified
because it contains type library locations on my machine.

test_s.bat is similar to test_c.bat, but it calls test_server.bat.

test_client.bat takes two arguments: name of the directory and 
name of the type library.
The script generates everything in D:\testing directory, which 
should exist before script starts. Obviously, the script can be modified
to accept the name of the root directory or have different root directory. 
The hard drive should have at least 1.5 GB of free space. The space is 
needed during the tests, and it is freed if all tests succeed.
The first argument is the name of subdirectory of d:\testing directory.

Line 11 contains full path to com_wizard_cmd.exe, and it is 
needed to be adjusted.
test_client.bat first removes any remains of previous tests with
the same subdirectory name, then it runs the wizard. If the test succeeds,
the generated directory is removed.
If the test fails, then the generated directory remains, and the file
DIRECTORY_NAME_failed is created, where DIRECTORY_NAME 
is the name of the first argument to the test_client.bat.

test_server.bat is very similar except it generates code in 
D:\testing_server directory, and it tests generating of a COM server.

The scripts are very short. I think they can be easily understood
just by looking into them.

test_status.bat has working directory name on line 13.
It is needs to be modified on every machine.

These scripts test only generation of a COM component from a COM definition
file. There are no scripts for testing generation of a COM componenet 
from an Eiffel Project.

