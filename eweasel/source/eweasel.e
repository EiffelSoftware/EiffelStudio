indexing
	description: "The EiffelWeasel automatic tester"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/09/14"

class EWEASEL

inherit
	INSTRUCTION_TABLES;
	OS_ACCESS;
	FILTER_CREATION;
	EXCEPTIONS;
	SHARED_OBJECTS

create	
	make,
	make_and_execute

feature  -- Creation

	make (args: ARRAY [STRING]) is
			-- Make
		do
			set_output (create {EWEASEL_OUTPUT_CONTROL}.make (io))
			parse_arguments (args)
			if not args_ok then
				display_help_instructions
			else
				check_test_suite_dir
				if args_ok then
					execute_init_control_file
				end
			end
		end

	make_and_execute (args: ARRAY [STRING]) is
			-- Make and execute tests in catalog file
		do
			make (args)			
			if args_ok then
				execute
			end
		end

feature -- Commands

	execute is
			-- Execute
		require
			able_to_execute: args_ok
		do
			display_version
			do_tests		
		end

feature -- Access

	environment: TEST_ENVIRONMENT;
			-- Initial environment for test suite

feature  {NONE} -- Implementation

	parse_arguments (args: ARRAY [STRING]) is
			-- Parse arguments `args' and execute any defines.
			-- Set `args_ok' to indicate whether the
			-- arguments were OK.
		local
			k, count: INTEGER;
			first_char, flag, type, l_filter: STRING;
			f: EIFFEL_TEST_FILTER;
		do
			from
				count := args.count - 1;
				create environment.make (0);
				create test_suite_options.make;
				create {ARRAYED_LIST [STRING]} test_catalog_names.make (5)
				args_ok := True;
				k := 1;
			until
				k > count or not args_ok
			loop
				first_char := args.item (k).substring (1, 1);
				if equal (first_char, "-") then
					flag := args.item (k).substring (2, args.item (k).count);
					if equal (flag, "define") then
						if count >= k + 2 then
							environment.define (args.item (k + 1), args.item (k + 2));
							k := k + 3;
						else
							args_ok := False;
						end
					elseif equal (flag, "keep") then
						if count >= k + 1 then
							k := k + 1;
							type := args.item (k)
							first_char := type.substring (1, 1);
							if equal (first_char, "-") then
								test_suite_options.set_keep_all
								k := k - 1
							elseif equal (type, "all") then
								test_suite_options.set_keep_all
							elseif equal (type, "passed") then
								test_suite_options.set_keep_passed
							elseif equal (type, "failed") then
								test_suite_options.set_keep_failed
							else
								args_ok := False;
							end
						else
							test_suite_options.set_keep_all
						end
						k := k + 1;
					elseif equal (flag, "clean") then
						test_suite_options.set_cleanup_requested (True)
						k := k + 1;
					elseif equal (flag, "help") then
						display_usage
						die (0)
					elseif equal (flag, "init") then
						if count >= k + 1 then
							initial_control_file := args.item (k + 1)
							k := k + 2
						else
							args_ok := False;
						end
					elseif equal (flag, "catalog") then
						if count >= k + 1 then
							test_catalog_names.extend (args.item (k + 1))
							k := k + 2
						else
							args_ok := False;
						end
					elseif equal (flag, "output") then
						if count >= k + 1 then
							test_suite_directory := args.item (k + 1);
							k := k + 2
						else
							args_ok := False;
						end
					elseif equal (flag, "filter") then
						if count >= k + 1 then
							l_filter := args.item (k + 1)
							f := string_to_filter (l_filter);
							if f /= Void then
								test_suite_options.set_filter (f);
								k := k + 2;
							else
								if filter_type = Void then
									output.append_error ("No filter type specified", True);
								elseif not is_filter_type_known then
									output.append_error ("Filter type `", False);
									output.append_error (filter_type, False);
									output.append_error ("' is not valid", True);
								elseif filter_count = 0 then
									output.append_error ("No filter values specified for filter type `", False);
									output.append_error (filter_type, False);
									output.append_error ("'", True);
								elseif filter_count > 1 then
									output.append_error (filter_count.out + " filter values specified for filter type `", False);
									output.append_error (filter_type, False);
									output.append_error ("' - not currently supported", True);
								end
								args_ok := False;
							end
						else
							args_ok := False;
						end
					else
						output.append_error ("Unknown option: ", False)
						output.append (args.item (k), True);
						args_ok := False;
					end
				else
					args_ok := False
				end
			end;

			if initial_control_file = Void then
				output.append_error ("No initial test control file specified (-init option omitted)", True)
				args_ok := False;
			end;
			if test_catalog_names.is_empty then	
				output.append_error ("No test catalogs specified (-catalog option omitted)", True)
				args_ok := False;
			end;
			if test_suite_directory = Void then	
				output.append_error ("No test output directory specified (-output option omitted)", True)
				args_ok := False;
			end;
		ensure
			environment_not_void: environment /= Void;
			options_not_void: test_suite_options /= Void;
			init_ctrl_file_ok: args_ok implies (initial_control_file /= Void);
			test_cat_name_ok: args_ok implies (not test_catalog_names.is_empty);
			test_suite_dir_ok: args_ok implies (test_suite_directory /= Void)
		end;

	check_test_suite_dir is
			-- Check that test suite directory exists
			-- and issue error message if it does not.
			-- Set `args_ok' to indicate success.
		require
			directory_not_void: test_suite_directory /= Void
		local
			dir: DIRECTORY;
		do
			create dir.make (test_suite_directory);
			if not dir.exists then
				args_ok := False;
				output.append_error ("Directory not found: ", False)
				output.append (test_suite_directory, False)
				output.append_new_line
			else
				args_ok := True;
			end;
		end;

	execute_init_control_file is
			-- Parse and execute the initial test control
			-- file in environment `environment' (possibly
			-- modifying `environment').  If any errors
			-- occur, report them.  Set `args_ok' to
			-- indicate success.
		require
			control_file_not_void: initial_control_file /= Void;
			environment_not_void: environment /= Void;
		local
			tcf: TEST_CONTROL_FILE;
		do
			create tcf.make (initial_control_file, Void, test_suite_command_table, False);
			tcf.parse_and_execute (environment);
			if not tcf.last_ok then
				args_ok := False;
				output.append_error ("Error in initial control file ", False)
				output.append (initial_control_file, True)
				tcf.errors.display;
			else
				args_ok := True;
				environment := tcf.environment;
			end
		end;

	do_tests is
			-- Construct list of tests from `test_catalog_names'
			-- and parse and execute them in `environment'
			-- with test suite directory `test_suite_directory'.
			-- Display test results.
		require
			catalog_names_not_void: test_catalog_names /= Void;
			catalog_names_not_empty: not test_catalog_names.is_empty
			environment_not_void: environment /= Void;
			directory_not_void: test_suite_directory /= Void
		local
			tcf: TEST_CATALOG_FILE;
			suite: EIFFEL_TEST_SUITE;
			ok: BOOLEAN
			tests: ARRAYED_LIST [NAMED_EIFFEL_TEST]
		do
			from
				ok := True
				create tests.make (100)
				test_catalog_names.start
			until
				test_catalog_names.after or not ok
			loop
				create tcf.make (test_catalog_names.item);
				tcf.parse (environment);
				if tcf.last_ok then
					tests.append (tcf.last_catalog.all_tests)
				else
					ok := False
					tcf.errors.display;
				end
				test_catalog_names.forth
			end
			
			if ok then
				create suite.make (tests, test_suite_directory, environment);
				suite.execute (test_suite_options);
				-- FIXME: put back in for multi threaded
				-- suite.execute_multithreaded (test_suite_options, 1);
			end
		end;

	display_help_instructions is
		do
			output.append ("Use -help option to display help", True)
		end;

	display_usage is
		do
			output.append_new_line
			output.append ("Usage: eweasel [-help] [-keep [{all | passed | failed}]] [-clean]%N   [-filter FILTER] [-define NAME VALUE ...] -init INIT_CONTROL_FILE%N   -catalog TEST_CATALOG -output TEST_SUITE_DIR", True)
			output.append ("Options (may appear in any order):", True)
			output.append ("	-help	Display this help message and exit.", True)
			output.append ("	-keep	Keep some test directories after execution, depending", True)
			output.append ("		on next argument (all, passed or failed).  If the next", True)
			output.append ("		argument is omitted, keep all test directories.", True)
			output.append ("	-clean	Delete EIFGENs directory after test finishes.", True)
			output.append ("		This option has no effect if -keep is not specified,", True)
			output.append ("		since every test directory will be deleted after execution.", True)
			output.append ("	-filter	Apply filter to select tests.", True)
			output.append ("		If no filter is given all tests in the catalog are executed.", True)
			output.append ("		Only one filter is supported - later -filter options override", True)
			output.append ("		earlier ones.", True)
			output.append ("		Filter can be one of:", True)
			output.append ("			'test TEST_NAME'", True)
			output.append ("			'directory TEST_DIRECTORY'", True)
			output.append ("			'keyword TEST_KEYWORD'", True)
			output.append ("		where TEST_NAME, TEST_DIRECTORY and TEST_KEYWORD refer", True)
			output.append ("		to test names, test directories and test keywords in the", True)
			output.append ("		test catalog.  You may use dir as a synonym for directory", True)
			output.append ("		and kw as a synonym for keyword.", True)
			output.append ("	-init	Specify initial test suite control file to be read.", True)
			output.append ("		This file should setup the eweasel environment.", True)
			output.append ("	-catalog Specify the name of a test catalog file.", True)
			output.append ("		This option may appear more than once", True)
			output.append ("		to specify multiple catalogs.", True)
			output.append ("	-output Name of test suite directory.  A directory is created in this", True)
			output.append ("		directory for each test that is executed.  Use the -keep and", True)
			output.append ("		-clean options to control whether which created test", True)
			output.append ("		directories are kept after execution and whether the EIFGENs", True)
			output.append ("		directory is deleted.", True)
			output.append ("	-define	Define name to have value during tests.", True)
			output.append ("		You need to define:", True)
			output.append ("			INCLUDE for directory with include files", True)
			output.append ("			ISE_EIFFEL for directory with Eiffel installation", True)
			output.append ("			ISE_PLATFORM for name of platform", True)
			output.append ("			VERSION for compiler version", True)
			output.append ("			PLATFORM_TYPE (unix, windows, dotnet)", True)
		end;

	display_version is
		do
			output.append ("%NEiffelWeasel test execution manager", True)
			output.append ("  (version 1.0.001)", True)
		end;

	
feature  -- Status

	args_ok: BOOLEAN;
			-- Were command line arguments valid?
	
feature  {NONE} -- Implementation

	initial_control_file: STRING;
			-- Name of control file to be read initially,
			-- to set up the environment with which all
			-- tests are to be started.
	
	test_catalog_names: LIST [STRING]
			-- Name of the test catalog file, which lists
			-- all possible tests.
	
	test_suite_directory: STRING;
			-- Name of the test directory.  Each test is
			-- conducted in a sub-directory of the test
			-- directory.

	test_suite_options: TEST_SUITE_OPTIONS;
			-- Options in effect for execution of test suite

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end
