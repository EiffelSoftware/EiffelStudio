note
	description: "The EiffelWeasel automatic tester"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class EW_EWEASEL

inherit
	EW_INSTRUCTION_TABLES
	EW_OS_ACCESS
	EW_FILTER_CREATION
	EXCEPTIONS
	EW_SHARED_OBJECTS
	EXECUTION_ENVIRONMENT

feature  -- Creation

	make (args: ARRAY [READABLE_STRING_32])
			-- Make
		do
			is_logo_enabled := True
			set_output (create {EW_EWEASEL_OUTPUT_CONTROL}.make (io))
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

	make_and_execute
			-- Make and execute tests in catalog file
		do
			is_logo_enabled := True
			make (arguments.argument_array)
			if args_ok then
				execute
			end
		end

feature -- Commands

	execute
			-- Execute
		require
			able_to_execute: args_ok
		do
			if is_logo_enabled then
				display_version
			end
			do_tests
		end

feature -- Access

	environment: EW_TEST_ENVIRONMENT
			-- Initial environment for test suite

feature -- Status

	args_ok: BOOLEAN
			-- Were command line arguments valid?

	is_logo_enabled: BOOLEAN
			-- Should logo information be displayed?

feature  {NONE} -- Implementation

	parse_arguments (args: ARRAY [READABLE_STRING_32])
			-- Parse arguments `args' and execute any defines.
			-- Set `args_ok' to indicate whether the
			-- arguments were OK.
		local
			k, count, n: INTEGER
			flag, type: READABLE_STRING_32
			l_max_threads, l_max_c_processes: READABLE_STRING_32
			f: EW_EIFFEL_TEST_FILTER
		do
			from
				count := args.count - 1
				create environment.make (0)
				create test_suite_options.make
				create {ARRAYED_LIST [PATH]} test_catalog_names.make (5)
				args_ok := True
				k := 1
			until
				k > count or not args_ok
			loop
				if args [k].starts_with_general ("-") then
					flag := args [k].substring (2, args [k].count)
					if flag.same_string_general ("define") then
						if count >= k + 2 then
							environment.define (args [k + 1], args [k + 2])
							k := k + 3
						else
							args_ok := False
						end
					elseif flag.same_string_general ("keep") then
						if count >= k + 1 then
							k := k + 1
							type := args [k]
							if type.starts_with_general ("-") then
								test_suite_options.set_keep_all
								k := k - 1
							elseif type.same_string_general ("all") then
								test_suite_options.set_keep_all
							elseif type.same_string_general ("passed") then
								test_suite_options.set_keep_passed
							elseif type.same_string_general ("failed") then
								test_suite_options.set_keep_failed
							else
								args_ok := False
							end
						else
							test_suite_options.set_keep_all
						end
						k := k + 1
					elseif flag.same_string_general ("clean") then
						test_suite_options.set_cleanup_requested (True)
						k := k + 1
					elseif flag.same_string_general ("noclean") then
						test_suite_options.set_cleanup_requested (False)
						k := k + 1
					elseif flag.same_string_general ("help") then
						display_usage
						die (0)
					elseif flag.same_string_general ("init") then
						if count >= k + 1 then
							initial_control_file := args [k + 1]
							k := k + 2
						else
							args_ok := False
						end
					elseif flag.same_string_general ("catalog") then
						if count >= k + 1 then
							test_catalog_names.extend (create {PATH}.make_from_string (args [k + 1]))
							k := k + 2
						else
							args_ok := False
						end
					elseif flag.same_string_general ("output") then
						if count >= k + 1 then
							test_suite_directory := args [k + 1]
							k := k + 2
						else
							args_ok := False
						end
					elseif flag.same_string_general ("filter") then
						if count >= k + 1 then
							f := string_to_filter (args [k + 1])
							if f /= Void then
								test_suite_options.set_filter (f)
								k := k + 2
							else
								if filter_type = Void then
									output.append_error ("No filter type specified", True)
								elseif not is_filter_type_known then
									output.append_error ("Filter type `", False)
									output.append_error_32 (filter_type, False)
									output.append_error ("' is not valid", True)
								elseif filter_count = 0 then
									output.append_error ("No filter values specified for filter type `", False)
									output.append_error_32 (filter_type, False)
									output.append_error ("'", True)
								elseif filter_count > 1 then
									output.append_error (filter_count.out + " filter values specified for filter type `", False)
									output.append_error_32 (filter_type, False)
									output.append_error ("' - not currently supported", True)
								end
								args_ok := False
							end
						else
							args_ok := False
						end
					elseif flag.same_string_general ("order") then
						test_suite_options.set_results_in_catalog_order (True)
						k := k + 1
					elseif flag.same_string_general ("noorder") then
						test_suite_options.set_results_in_catalog_order (False)
						k := k + 1
					elseif flag.same_string_general ("max_threads") then
						if count >= k + 1 then
							l_max_threads := args [k + 1]
							if l_max_threads.is_integer then
								n := l_max_threads.to_integer
								if n >= -1 then
									test_suite_options.set_max_threads (n)
									k := k + 2
								else
									output.append_error_32 ({STRING_32} "Invalid maximum thread count " + n.out + " - must be >= -1", True)
									args_ok := False
								end
							else
								output.append_error_32 ({STRING_32} "Invalid maximum thread count: " + l_max_threads, True)
								args_ok := False
							end
						else
							args_ok := False
						end
					elseif flag.same_string_general ("max_c_processes") then
						if count >= k + 1 then
							l_max_c_processes := args [k + 1]
							if l_max_c_processes.is_integer then
								n := l_max_c_processes.to_integer
								if n >= -1 then
									test_suite_options.set_max_c_processes (n)
									k := k + 2
								else
									output.append_error_32 ({STRING_32} "Invalid maximum C processes value " + n.out + " - must be >= -1", True)
									args_ok := False
								end
							else
								output.append_error_32 ({STRING_32} "Invalid maximum C processes value: " + l_max_c_processes, True)
								args_ok := False
							end
						else
							args_ok := False
						end
					elseif flag.same_string_general ("nologo") then
						k := k + 1
						is_logo_enabled := False
					elseif flag.same_string_general ("nosummary") then
						k := k + 1
						test_suite_options.set_display_summary (False)
					else
						output.append_error ("Unknown option: ", False)
						output.append_32 (args [k], True)
						args_ok := False
					end
				else
					args_ok := False
				end
			end

			environment.set_max_c_processes (test_suite_options.max_c_processes)

			if initial_control_file = Void then
				output.append_error ("No initial test control file specified (-init option omitted)", True)
				args_ok := False
			end
			if test_catalog_names.is_empty then
				output.append_error ("No test catalogs specified (-catalog option omitted)", True)
				args_ok := False
			end
			if test_suite_directory = Void then
				output.append_error ("No test output directory specified (-output option omitted)", True)
				args_ok := False
			end
		ensure
			environment_not_void: environment /= Void
			options_not_void: test_suite_options /= Void
			init_ctrl_file_ok: args_ok implies (initial_control_file /= Void)
			test_cat_name_ok: args_ok implies (not test_catalog_names.is_empty)
			test_suite_dir_ok: args_ok implies (test_suite_directory /= Void)
		end

	check_test_suite_dir
			-- Check that test suite directory exists
			-- and issue error message if it does not.
			-- Set `args_ok' to indicate success.
		require
			directory_not_void: test_suite_directory /= Void
		local
			dir: DIRECTORY
		do
			create dir.make_with_name (test_suite_directory)
			if not dir.exists then
				args_ok := False
				output.append_error ("Directory not found: ", False)
				output.append_32 (test_suite_directory, False)
				output.append_new_line
			else
				args_ok := True
			end
		end

	execute_init_control_file
			-- Parse and execute the initial test control
			-- file in environment `environment' (possibly
			-- modifying `environment').  If any errors
			-- occur, report them.  Set `args_ok' to
			-- indicate success.
		require
			control_file_not_void: initial_control_file /= Void
			environment_not_void: environment /= Void
		local
			tcf: EW_TEST_CONTROL_FILE
		do
			create tcf.make (initial_control_file, Void, test_suite_command_table, False)
			tcf.parse_and_execute (environment)
			if not tcf.last_ok then
				args_ok := False
				output.append_error ("Error in initial control file ", False)
				output.append_32 (initial_control_file, True)
				tcf.errors.display
			else
				args_ok := True
				environment := tcf.environment
			end
		end

	do_tests
			-- Construct list of tests from `test_catalog_names'
			-- and parse and execute them in `environment'
			-- with test suite directory `test_suite_directory'.
			-- Display test results.
		require
			catalog_names_not_void: attached test_catalog_names as ts
			catalog_names_not_empty: not ts.is_empty
			environment_not_void: environment /= Void
			directory_not_void: test_suite_directory /= Void
		local
			tcf: EW_TEST_CATALOG_FILE
			suite: EW_EIFFEL_TEST_SUITE
			ok: BOOLEAN
			tests: ARRAYED_LIST [EW_NAMED_EIFFEL_TEST]
		do
			check
				from_precondition: attached test_catalog_names as ts
			then
				across
					ts as t
				from
					ok := True
					create tests.make (100)
				until
					not ok
				loop
					create tcf.make (t.item)
					tcf.parse (environment)
					if tcf.last_ok then
						tests.append (tcf.last_catalog.all_tests)
					else
						ok := False
						tcf.errors.display
					end
				end
				if ok then
					suite := new_test_suite (tests, test_suite_options)
					suite.execute (test_suite_options)
					if suite.fail_count > 0 then
							-- Some tests are failing, we exit with an error code
							-- matching the number of failures (but limited to 255
							-- since on UNIX it is limited from 0 to 255.
						(create {EXCEPTIONS}).die (suite.fail_count.min (255))
					end
				end
			end
		end

	display_help_instructions
		do
			output.append ("Use -help option to display help", True)
		end

	display_usage
		do
			output.append_new_line
			output.append ("Usage:", True)
			output.append ("   eweasel [-help] [-nologo] [-nosummary]", True)
			output.append ("      [-max_threads COUNT] [-max_c_processes COUNT]", True)
			output.append ("      [-order | -noorder] [-keep [{all | passed | failed}]] [-clean | -noclean]", True)
			output.append ("      [-filter FILTER] [-define NAME VALUE ...]", True)
			output.append ("      -init INIT_CONTROL_FILE -catalog TEST_CATALOG -output TEST_SUITE_DIR", True)
			output.append ("", True)
			output.append ("Options (may appear in any order and later options override earlier options):", True)
			output.append ("", True)
			output.append ("   -help        Display this help message and exit.", True)
			output.append ("   -max_threads Specify maximum number of worker threads for multithreaded", True)
			output.append ("                eweasel.  Default is -1 (do all tests in main thread).", True)
			output.append ("                Value of 0 will curently cause a hang in MT version.", True)
			output.append ("                Ignored in single-threaded version.", True)
			output.append ("   -max_c_processes", True)
			output.append ("                Specify maximum number of processes to use simultaneously for", True)
			output.append ("                C compilations for any test that requires C compilations. ", True)
			output.append ("                Default is number of processors on machine. ", True)
			output.append ("   -order       Display test execution results in catalog order.", True)
			output.append ("   -noorder     Display test execution results as soon as they available.", True)
			output.append ("                This is the default.  Ignored in single-threaded version.", True)
			output.append ("   -keep        Keep some test directories after execution, depending", True)
			output.append ("                on next argument (all, passed or failed).  If the next", True)
			output.append ("                argument is omitted, keep all test directories.", True)
			output.append ("   -clean       Delete EIFGENs directory after each test finishes.", True)
			output.append ("                This option has no effect if -keep is not specified,", True)
			output.append ("                since every test directory will be deleted after execution.", True)
			output.append ("   -noclean     Do not delete EIFGENs directory after test finishes (default).", True)
			output.append ("   -filter      Apply filter to select tests.", True)
			output.append ("                If no filter is given all tests in the catalog are executed.", True)
			output.append ("                Only one filter is supported - later filter options override", True)
			output.append ("                earlier ones.", True)
			output.append ("                Filter can be one of:", True)
			output.append ("                    'test TEST_NAME'", True)
			output.append ("                    'directory TEST_DIRECTORY'", True)
			output.append ("                    'keyword TEST_KEYWORD'", True)
			output.append ("                where TEST_NAME, TEST_DIRECTORY and TEST_KEYWORD refer", True)
			output.append ("                to test names, test directories and test keywords in the", True)
			output.append ("                test catalog.  You may use dir as a synonym for directory", True)
			output.append ("                and kw as a synonym for keyword.", True)
			output.append ("   -init        Specify initial test suite control file to be read.", True)
			output.append ("                This file should setup the eweasel environment.", True)
			output.append ("   -catalog     Specify the name of a test catalog file.  This option may", True)
			output.append ("                appear more than once to specify multiple catalogs.", True)
			output.append ("   -output      Name of test suite directory.  A directory is created in this", True)
			output.append ("                directory for each test that is executed.  Use the -keep and", True)
			output.append ("                -clean options to control whether created test directories", True)
			output.append ("                are kept after execution and whether the EIFGENs directory", True)
			output.append ("                is deleted.", True)
			output.append ("   -define      Define name to have value during tests.", True)
			output.append ("                You need to define:", True)
			output.append ("                    INCLUDE for directory with include files", True)
			output.append ("                    ISE_EIFFEL for directory with Eiffel installation", True)
			output.append ("                    ISE_PLATFORM for name of platform", True)
			output.append ("                    VERSION for compiler version", True)
			output.append ("                    PLATFORM_TYPE (unix, windows, dotnet)", True)
			output.append ("   -nologo      Suppress copyright message and version information.", True)
			output.append ("   -nosummary   Suppress summary of test results.", True)
		end

	display_version
		local
			revision: STRING
		do
			output.append ("EiffelWeasel test execution manager", False)
			revision := "$Revision$"
				-- Remove leading "$Revision: ".
			revision.remove_head (11)
				-- Remove trailing " $".
			revision.remove_tail (2)
			output.append (" (version 1.3.1." + revision + ")", True)
		end

	new_test_suite (tests: LIST [EW_NAMED_EIFFEL_TEST] opts: EW_TEST_SUITE_OPTIONS): EW_EIFFEL_TEST_SUITE
			-- New test suite with `tests' using options `opts'
		require
			tests_not_void: tests /= Void
			opts_not_void: opts /= Void
		deferred
		end

	initial_control_file: READABLE_STRING_32
			-- Name of control file to be read initially,
			-- to set up the environment with which all
			-- tests are to be started.

	test_catalog_names: LIST [PATH]
			-- Name of the test catalog file, which lists
			-- all possible tests.

	test_suite_directory: READABLE_STRING_32
			-- Name of the test directory.  Each test is
			-- conducted in a sub-directory of the test
			-- directory.

	test_suite_options: EW_TEST_SUITE_OPTIONS
			-- Options in effect for execution of test suite

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
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
