indexing
	description: "A worker that (separate thread of control) that %
		%executes named Eiffel tests"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "September 13, 2001"

class EIFFEL_TEST_EXECUTOR

inherit
	THREAD
	OS_ACCESS
		export
			{NONE} all
		end

feature -- Execution

	execute is
			-- Execute named Eiffel tests until there are
			-- no more to be executed
		require else
			options_exist: options /= Void
			queue_exists: queue /= Void
			test_suite_exists: test_suite /= Void
		local
			test: NAMED_EIFFEL_TEST;
			done: BOOLEAN
			test_dir: STRING;
		do
			from
				done := False
			until
				done
			loop
				test := queue.next_waiting_test
				if test = Void then
					done := True
				else
					if test.execution_allowed then
						test.execute (test_suite.initial_environment (test));
						if not options.keep_all_output then
							test_dir := os.full_directory_name (test_suite.test_suite_directory, test.last_source_directory_component);
							os.delete_directory_tree (test_dir)
						end
					end
					queue.mark_test_completed (test)
				end
			end
		end;


feature -- Properties

	queue: EIFFEL_TEST_QUEUE
			-- Queue of tests to be executed
	
	options: TEST_SUITE_OPTIONS
			-- Options for test suite execution
	
	test_suite: EIFFEL_TEST_SUITE
			-- Test suite containing tests to be executed
	
feature -- Modification

	set_queue (q: EIFFEL_TEST_QUEUE) is
			-- Set `queue' to `q'
		do
			queue := q
		end
	
	set_options (opts: TEST_SUITE_OPTIONS) is
			-- Set `options' to `opts'
		do
			options := opts
		end
	
	set_test_suite (s: EIFFEL_TEST_SUITE) is
			-- Set `test_suite' to `s'
		do
			test_suite := s
		end

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
