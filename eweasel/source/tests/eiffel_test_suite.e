indexing
	description: "An Eiffel test suite"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/09/14"

class EIFFEL_TEST_SUITE

inherit
	EIFFEL_TEST_CONSTANTS;
	PREDEFINED_VARIABLES;
	OS_ACCESS;
	EXCEPTIONS;
	SHARED_OBJECTS
	REFACTORING_HELPER
	-- FIXME: put back in for multi threaded
	-- THREAD_CONTROL

create

	make

feature  -- Creation

	make (list: LIST [NAMED_EIFFEL_TEST]; dir: STRING; env: TEST_ENVIRONMENT) is
			-- Create `Current' with list of Eiffel tests `list',
			-- test suite directory `dir' and intiial
			-- environment for each test `env'.
		require
			test_list_not_void: list /= Void;
			directory_not_void: dir /= Void;
			environment_not_void: env /= Void;
		do
			test_list := list;
			test_suite_directory := dir;
			test_suite_environment := env;
		end;

feature -- Execution

	execute (opts: TEST_SUITE_OPTIONS) is
			-- Execute `Current' as modified by options `opts'
			-- and display the results
			-- of each test and pass/fail statistics on all tests.
			-- Leave the number of tests which passed in
			-- `pass_count' and the number which failed in
			-- `fail_count'.
		require
			options_not_void: opts /= Void;
		local
			test: NAMED_EIFFEL_TEST;
			test_dir, compiler_dir: STRING;
		do
			from
				test_list.start;
			until
				test_list.after
			loop
				test := test_list.item;
				if opts.filter.selects (test) then
					announce_start (test);
					if test.execution_allowed then
						test.execute (initial_environment (test));
						test_dir := os.full_directory_name (test_suite_directory, test.last_source_directory_component);
						if opts.keep_all or (opts.keep_passed and test.last_ok) or (opts.keep_failed and not test.last_ok) then
							if opts.is_cleanup_requested then
								compiler_dir := os.full_directory_name (test_dir, Eiffel_gen_directory)
								os.delete_directory_tree (compiler_dir)
							end
						else
							os.delete_directory_tree (test_dir)
						end
					end;
					update_statistics (test);
					display_results (test);
				end;
				test_list.forth;
				output.update
			end;
			display_summary;
		end;

--	execute_multithreaded (opts: TEST_SUITE_OPTIONS threads: INTEGER) is
--			-- FIXME: put back in for multi threaded
--			-- Execute `Current' as modified by options `opts'
--			-- and display the results
--			-- of each test and pass/fail statistics on all tests.
--			-- Use `threads' threads to execute the tests
--		require
--			options_not_void: opts /= Void
--			positive_thread_count: threads > 0
--		local
--			test: NAMED_EIFFEL_TEST;
--			test_dir: STRING;
--			queue: EIFFEL_TEST_QUEUE
--			k: INTEGER
--			executor: EIFFEL_TEST_EXECUTOR
--			done: BOOLEAN
--		do
--			create queue.make
--			from
--				k := 1
--			until
--				k > threads
--			loop
--				create executor
--				executor.set_queue (queue)
--				executor.set_options (opts)
--				executor.set_test_suite (Current)
--				executor.launch
--				k := k + 1
--			end
--			
--			from
--				test_list.start;
--			until
--				test_list.after
--			loop
--				test := test_list.item;
--				if opts.filter.selects (test) then
--					queue.extend (test)
--				end;
--				test_list.forth;
--			end;
--			
--			from
--				done := False
--			until
--				done
--			loop
--				test := queue.next_completed_test
--				if test = Void then
--					done := True
--				else
--					update_statistics (test);
--					announce_start (test);
--					display_results (test);
--				end
--			end;
--			join_all
--			display_summary;
--		end;


feature -- Statistics	

	pass_count: INTEGER;
			-- Number of tests which have passed so far

	fail_count: INTEGER;
			-- Number of tests which have failed so far

	manual_count: INTEGER;
			-- Number of tests which were not executed because
			-- they were marked as requiring manual execution

	skip_count: INTEGER;
			-- Number of tests which were not executed because
			-- they were marked as "skip" (does not include
			-- any tests which require manual execution)

feature {NONE} -- Implementation	

	test_list: LIST [NAMED_EIFFEL_TEST];
			-- List of all tests to be performed.

	test_suite_environment: TEST_ENVIRONMENT;
			-- Common environment shared by all tests in the
			-- test suite (possibly augmented by other
			-- definitions before each test is started).

feature {NONE} -- Implementation	

-- feature {EIFFEL_TEST_EXECUTOR} -- Implementation	
-- FIXME: put back in for multi threaded (replace above line with {NONE})

	test_suite_directory: STRING;
			-- Name of the directory in which test
			-- suite is to be executed.  Each test is
			-- conducted in a sub-directory of the test
			-- directory.

	initial_environment (test: NAMED_EIFFEL_TEST): TEST_ENVIRONMENT is
			-- Initial environment environment in which to
			-- execute `test'.  The result may be safely
			-- modified by the caller.
		require
			test_not_void: test /= Void
		local
			test_dir, gen_dir, exec_dir: STRING;
		do
			Result := test_suite_environment.deep_twin
			test_dir := os.full_directory_name (test_suite_directory, test.last_source_directory_component);
			associate (Result, Test_dir_name, test_dir);
			associate (Result, Cluster_dir_name, os.full_directory_name (test_dir, "clusters"));
			associate (Result, Output_dir_name, os.full_directory_name (test_dir, "output"));
			fixme ("set correct directory depending on used target")
			gen_dir := os.full_directory_name (test_dir, Eiffel_gen_directory)
			gen_dir := os.full_directory_name (gen_dir, Default_system_name)
			exec_dir := os.full_directory_name (gen_dir, Work_c_code_directory);
			Result.define (Work_execution_dir_name, exec_dir);
			exec_dir := os.full_directory_name (gen_dir, Final_c_code_directory);
			Result.define (Final_execution_dir_name, exec_dir);
		ensure
			result_not_void: Result /= Void
		end;

feature {NONE} -- Implementation	

	associate (env: TEST_ENVIRONMENT; var, dir: STRING) is
			-- Define an environment variable `var' in the
			-- environment `env' to have
			-- value `dir', which must be a directory name.
			-- Create the directory `dir' if it does not exist.
		require
			environment_not_void: env /= Void;
			var_name_not_void: var /= Void;
			directory_not_void: dir /= Void;
		local
			d: DIRECTORY;
		do
				env.define (var, dir);
				create d.make (dir);
				if not d.exists then
					d.create_dir;
				end;
		end;

	announce_start (test: NAMED_EIFFEL_TEST) is
			-- Announce the start of execution of `test'
		require
			test_not_void: test /= Void
		do
			output.append ("Test ", False)
			output.append (test.test_name, False);
			output.append (" (", False);
			output.append (test.last_source_directory_component, False);
			output.append (")", False);
			output.flush;
		end;


	display_results (test: NAMED_EIFFEL_TEST) is
			-- Display the status of execution of `test'
		require
			test_not_void: test /= Void
		do
			if test.last_test /= Void and then not equal (test.last_test.test_name, test.test_name) then
					-- Test has different name than named test
				output.append (" [", False);
				output.append (test.last_test.test_name, False);
				output.append ("]", False);
			end;
			output.append (": ", False);
			if test.manual_execution_required then
				output.append ("manual", True);
			elseif test.skip_requested then
				output.append ("skipped", True);
			elseif test.last_ok then
				output.append ("passed", True);
			else
				output.append_error ("failed", True);
				output.append ("%TDescription: ", False);
				if test.last_test /= Void then
					output.append (test.last_test.test_description, False);
				else
					output.append ("(Not available)", False)
				end;
				output.append_new_line;
				test.errors.display;
			end;
			output.flush;
		end;

	update_statistics (test: NAMED_EIFFEL_TEST) is
			-- Update cumulative statistics for a test,
			-- based on the result of `test' if it was executed
			-- and on its characteristics if it was not executed
		require
			test_not_void: test /= Void
		do
			if test.manual_execution_required then
				manual_count := manual_count + 1;
			elseif test.skip_requested then
				skip_count := skip_count + 1;
			elseif test.last_ok then
				pass_count := pass_count + 1;
			else
				fail_count := fail_count + 1;
			end;
		end;

	display_summary is
			-- Display a summary of results of executing
			-- all tests in the suite
		local
			total: INTEGER
		do
			total := pass_count + fail_count + manual_count + skip_count;
			output.append_new_line;
			if total = 0 then
				output.append ("No tests selected", True);
			else
				display_stats_if_nonzero ("Passed", pass_count, total);
				display_stats_if_nonzero ("Failed", fail_count, total);
				display_stats_if_nonzero ("Manual", manual_count, total);
				display_stats_if_nonzero ("Skipped", skip_count, total);
			end;
			output.append_new_line;
		end;

	display_stats_if_nonzero (status: STRING; num, total: INTEGER) is
			-- Display statistics for tests.  `num' tests out
			-- of a total of `total' tests completed with
			-- status `status'.
		do
			if num > 0 then
				output.append (status, False);
				output.append (":  ", False);
				output.append (num.out, False);
				output.append (" / ", False);
				output.append (total.out, False);
				output.append ("  (", False);
				output.append (percent (num, total).out, False);
				output.append ("%%)", True);
			end
		end;

	percent (num, denom: INTEGER): INTEGER is
			-- Percentage represented by `num' / `denom'
		local
			n, d: REAL;
		do
			n := num;
			d := denom;
			Result := (n / d * 100.0 + .49999).rounded;
		end;

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
