note
	description: "A worker that (separate thread of control) that %
		%executes named Eiffel tests"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_EIFFEL_TEST_EXECUTOR

inherit
	EW_EIFFEL_TEST_CONSTANTS
	THREAD
	EW_OS_ACCESS
		export
			{NONE} all
		end
	EW_SHARED_THREAD_DEBUGGING
		export
			{NONE} all
		end

create
	make

feature -- Execution

	execute
			-- Execute named Eiffel tests until there are
			-- no more to be executed
		require else
			options_exist: options /= Void
			queue_exists: queue /= Void
			test_suite_exists: test_suite /= Void
		local
			test: EW_NAMED_EIFFEL_TEST
			done: BOOLEAN
			test_dir: READABLE_STRING_32
		do
			register
			debug ("threaded_eweasel")
				print_debug_worker ("Registered worker thread")
			end
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
						debug ("threaded_eweasel")
							print_debug_worker ({STRING_32} "Executing test " + test.last_source_directory_component)
						end
						test.execute (test_suite.initial_environment (test));
						test_dir := os.full_directory_name (test_suite.test_suite_directory, test.last_source_directory_component);
						if options.keep_all or (options.keep_passed and test.last_ok) or (options.keep_failed and not test.last_ok) then
							if options.is_cleanup_requested then
								os.delete_directory_tree (os.full_directory_name (test_dir, Eiffel_gen_directory))
							end
						else
							os.delete_directory_tree (test_dir)
						end
						debug ("threaded_eweasel")
							print_debug_worker ({STRING_32} "Finished test " + test.last_source_directory_component)
						end
					end
					queue.mark_test_completed (test)
				end
			end
			debug ("threaded_eweasel")
				print_debug_worker ("Worker thread exiting")
			end
		end;


feature -- Properties

	queue: EW_EIFFEL_TEST_QUEUE
			-- Queue of tests to be executed

	options: EW_TEST_SUITE_OPTIONS
			-- Options for test suite execution

	test_suite: EW_EIFFEL_TEST_SUITE
			-- Test suite containing tests to be executed

feature -- Modification

	set_queue (q: EW_EIFFEL_TEST_QUEUE)
			-- Set `queue' to `q'
		do
			queue := q
		end

	set_options (opts: EW_TEST_SUITE_OPTIONS)
			-- Set `options' to `opts'
		do
			options := opts
		end

	set_test_suite (s: EW_EIFFEL_TEST_SUITE)
			-- Set `test_suite' to `s'
		do
			test_suite := s
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
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
