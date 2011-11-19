This library is a simplified version of ESpec without the GUI facilities.

Sample projects are included in the "tests" folder. For more instructions on how to use ESpec please
compile the "demo" project included in the "tests" folder. This project will provide information on how
to setup and run the tests.

The "show_browser" command (inserted before the "run_espec" command) will bring up the test results in
the default browser (i.e. iexplorer for Windows and firefox on Linux). 

The "show_errors" command (inserted before the "run_espec" command) will show the full trace of contract
violations in the generated output.

The user can change the default browser (see {ES_TEST_SUITE}.check_browser" in the library).

FOLLOW THESE STEPS BEFORE USING ESPEC:

1- Install Eiffel Studio from eiffel.com
2- set an environmental variable called "ESPEC" and point it to the "espec_simple" folder. In windows
this is done in the "System" control panel (see advanced system settings). 

TO ADD THE LIBRARY TO AN EXISTING PROJECT:
1- Open "project settings window" from Eiffel Studio
2- Click on groups
3- Click on libraries
4- Click on "add library"
5- In the name field type "espec" in the location "$ESPEC/library/espec.ecf

TO RUN TESTS
1- Freeze the system (by pressing crl-f7) and wait for the C compilation to complete.
2- press the little down arrow next to the run button, and invoke "run workbench system", that will bring a
browser window with the results of your tests .



Oct 28 2011
Faraz Torshizi
Dr. Jonathan Ostroff