This library is a simplified version of ESpec without the GUI facilities.

After adding the espec library (see below) the following class will run a test "t1".

---------------------------------
class ROOT inherit ES_TEST create
	make
feature {NONE} -- Initialization
	make
		do
			add_boolean_case (agent t1)
			show_browser; show_errors; run_espec
		end
feature --tests
	t1: BOOLEAN
		local
			a: ARRAY[INTEGER]
		do
			comment("t1: test array count query")
			a := <<10, 9, 8>>
			Result := a.count = 3
		end
end
---------------------------------

Sample projects are included in the "tests" folder. For more instructions on how to use ESpec (e.g. for suits of tests) please compile the "demo" project included in the "tests" folder. This project will provide information on howto setup and run the tests.

The "show_browser" command (inserted before the "run_espec" command) will bring up the test results in the default browser (i.e. iexplorer for Windows and firefox on Linux). 

The "show_errors" command (inserted before the "run_espec" command) will show the full trace of contract violations in the generated output.

The user can change the default browser (see {ES_TEST_SUITE}.check_browser" in the library).

FOLLOW THESE STEPS BEFORE USING ESPEC:

1- Install Eiffel Studio from eiffel.com

TO ADD THE LIBRARY TO AN EXISTING PROJECT:
1- Open "project settings window" from Eiffel Studio
2- Click on groups
3- Click on libraries
4- Click on "add library"
5- In the name field type "espec" in the location type:
"$ISE_LIBRARY\contrib\library\testing\framework\espec\library\espec-safe.ecf"/>"

Or, add the following to the ecf file:
"<library name="espec" location="$ISE_LIBRARY\contrib\library\testing\framework\espec\library\espec-safe.ecf"/>"

TO RUN TESTS
1- Freeze the system (by pressing crl-f7) and wait for the C compilation to complete.
2- press the little down arrow next to the run button (crl-alt-F5 in windows), and invoke "run workbench system", that will bring a
browser window with the results of your tests .



Oct 28 2011
Faraz Torshizi
Jonathan Ostroff
Software Engineering Lab
York University, Toronto

Revision History
================

17 April 2012
Renamed the folder to espec (from espec-simple).
Fixed obsolete assignment attempts in routines
{ES_VIOLATION_CLASS} write_passed_case
{ES_VIOLATION_CLASS} write_failed_case
Fixed obsolete calls in tests:dictionary.

9 January 2014
--------------

Fixed some errors reported by new void safe checks
Added MacOs as supported system for browser report
Added features: assert_equal, assert_not_equal, assert and sub_comment

See 
  * https://wiki.eecs.yorku.ca/project/eiffel/getting_started:
  * https://wiki.eecs.yorku.ca/project/eiffel/getting_started:espec for new features
