indexing
	description: "An Eiffel test suite - multi-threaded version"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/09/14"

class EW_EIFFEL_TEST_SUITE_MT

inherit
	EW_EIFFEL_TEST_SUITE
	THREAD_CONTROL
	EW_SHARED_THREAD_DEBUGGING
		export
			{NONE} all
		end

create

	make

feature -- Execution

	execute (opts: EW_TEST_SUITE_OPTIONS) is
			-- Execute `Current' as modified by options `opts'
			-- and display the results
			-- of each test and pass/fail statistics on all tests.
		local
			test: EW_NAMED_EIFFEL_TEST;
			queue: EW_EIFFEL_TEST_QUEUE
			executor: EW_EIFFEL_TEST_EXECUTOR
			done: BOOLEAN
			num_threads, max_threads: INTEGER
		do
			debug ("threaded_eweasel")
				print_debug_main ("Starting multithreaded eweasel")
			end
			max_threads := opts.max_threads
			create queue.make
			queue.set_results_in_catalog_order (opts.results_in_catalog_order)
			
			debug ("threaded_eweasel")
				print_debug_main ("Started adding tests selected by filter to test queue")
			end
			from
				num_threads := 0
				test_list.start;
			until
				test_list.after
			loop
				test := test_list.item;
				if opts.filter.selects (test) then
					debug ("threaded_eweasel")
						print_debug_main ("Adding " + test.last_source_directory_component + " to test queue")
					end
					queue.extend (test)
					debug ("threaded_eweasel")
						print_debug_main ("Added " + test.last_source_directory_component + " to test queue")
					end
					if num_threads < max_threads then
						num_threads := num_threads + 1
						debug ("threaded_eweasel")
							print_debug_main ("Creating thread "	+ num_threads.out)
						end
						create executor
						executor.set_queue (queue)
						executor.set_options (opts)
						executor.set_test_suite (Current)
						executor.launch
						debug ("threaded_eweasel")
							print_debug_main ("Launched thread "	+ num_threads.out)
						end
					end
				end;
				test_list.forth;
			end;
			debug ("threaded_eweasel")
				print_debug_main ("Done adding tests selected by filter to test queue")
			end
			queue.set_all_tests_added
			debug ("threaded_eweasel")
				print_debug_main ("Broadcasted %"all tests added%" condition")
			end
			
			from
				done := False
			until
				done
			loop
				debug ("threaded_eweasel")
					print_debug_main ("Waiting for next completed test")
				end
				test := queue.next_completed_test
				if test = Void then
					done := True
				else
					debug ("threaded_eweasel")
						print_debug_main ("Test " + test.last_source_directory_component + " completed")
					end
					update_statistics (test);
					announce_start (test);
					display_results (test);
				end
			end;
			debug ("threaded_eweasel")
				print_debug_main ("All tests have completed" )
			end
			queue.broadcast_all_tests_completed
			debug ("threaded_eweasel")
				print_debug_main ("Calling join_all to wait for child threads to terminate" )
			end
			join_all
			debug ("threaded_eweasel")
				print_debug_main ("All child threads have terminated" )
			end
			display_summary;
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
