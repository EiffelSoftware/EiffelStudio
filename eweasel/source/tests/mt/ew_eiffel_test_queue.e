note
	description: "A queue of named Eiffel tests that can be extended %
		%by multiple threads and worked on by multiple threads"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EW_EIFFEL_TEST_QUEUE

inherit
	ANY
	EW_SHARED_THREAD_DEBUGGING
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make
		do
			create mutex.make
			create pending_queue.make (100)
			create executing_queue.make (20)
			create completed_queue.make (20)
			create more_waiting_tests.make
			create more_completed_tests.make
		end

feature -- Properties

	all_tests_added: BOOLEAN
			-- Has producer finished adding tests to
			-- the queue?

	results_in_catalog_order: BOOLEAN
			-- Should test execution results be reported
			-- in order tests appear in catalog?
			-- If not, test results are reported as soon as
			-- they are available.
			-- Ignored if single threaded


feature -- Modification

	set_results_in_catalog_order (b: BOOLEAN)
		do
			results_in_catalog_order := b
		ensure
			results_in_catalog_order_set: results_in_catalog_order = b
		end;

	extend (t: EW_NAMED_EIFFEL_TEST)
			-- Add `t' to end of list of tests
		local
			entry: EW_EIFFEL_TEST_QUEUE_ENTRY
		do
			create entry.make (t)
			debug ("threaded_eweasel")
				print_debug_main ("Trying to lock mutex in extend")
			end
			mutex.lock
			debug ("threaded_eweasel")
				print_debug_main ("Locked mutex in extend")
			end
			pending_queue.extend (entry)
			debug ("threaded_eweasel")
				print_debug_main ("Signalling more waiting tests in extend")
			end
			more_waiting_tests.signal
			debug ("threaded_eweasel")
				print_debug_main ("Signalled more waiting tests in extend")
			end
			mutex.unlock
			debug ("threaded_eweasel")
				print_debug_main ("Unlocked mutex in extend")
			end
		end

	mark_test_completed (t: EW_NAMED_EIFFEL_TEST)
			-- Mark test `t' as completed (no longer awaiting
			-- execution)
		local
			done: BOOLEAN
			entry: EW_EIFFEL_TEST_QUEUE_ENTRY
			queue: like pending_queue
		do
			debug ("threaded_eweasel")
				print_debug_worker ("Trying to lock mutex in mark_test_completed")
			end
			mutex.lock
			debug ("threaded_eweasel")
				print_debug_worker ("Locked mutex in mark_test_completed")
			end
			if results_in_catalog_order then
				queue := pending_queue
			else
				queue := executing_queue
			end
			from
				queue.start
			until
				queue.after or done
			loop
				entry := queue.item
				if entry.test = t then
					debug ("threaded_eweasel")
						print_debug_worker ({STRING_32} "Marking test queue entry for " + entry.test.last_source_directory_component + " completed in mark_test_completed")
					end
					entry.set_waiting (False)
					entry.set_in_use (False)
					done := True
					if not results_in_catalog_order then
						queue.remove
						completed_queue.extend (entry)
					end
				end
					-- We have to protect the call because the previous call
					-- to `queue.remove' may have render `queue.after' True.
				if not queue.after then
					queue.forth
				end
			end
			debug ("threaded_eweasel")
				print_debug_worker ("Signalling more completed tests in mark_test_completed")
			end
			more_completed_tests.signal
			debug ("threaded_eweasel")
				print_debug_worker ("Signalling more waiting tests in mark_test_completed")
			end
			more_waiting_tests.signal
				-- Wake up one blocked thread since
				-- one test finished
			debug ("threaded_eweasel")
				print_debug_worker ("Unlocking mutex in mark_test_completed")
			end
			mutex.unlock
			debug ("threaded_eweasel")
				print_debug_worker ("Mutex unlocked in mark_test_completed")
			end
		end

	next_waiting_test: detachable EW_NAMED_EIFFEL_TEST
			-- Next test awaiting execution or Void if
			-- no more tests
		local
			no_tests: BOOLEAN
			entry: EW_EIFFEL_TEST_QUEUE_ENTRY
		do
			from

			until
				Result /= Void or no_tests
			loop
				debug ("threaded_eweasel")
					print_debug_worker ("Trying to lock mutex in next_waiting_test")
				end
				mutex.lock
				debug ("threaded_eweasel")
					print_debug_worker ("Locked mutex in next_waiting_test")
				end
				from
					pending_queue.start
				until
					pending_queue.after or Result /= Void
				loop
					entry := pending_queue.item
					if entry.waiting and not entry.in_use then
						entry.set_in_use (True)
						Result := entry.test
						if not results_in_catalog_order then
							pending_queue.remove
							executing_queue.extend (entry)
						end
						debug ("threaded_eweasel")
							print_debug_worker ({STRING_32} "Found waiting test " + Result.last_source_directory_component + " in next_waiting_test")
						end
					end
					pending_queue.forth
				end
				no_tests := Result = Void and all_tests_added
				debug ("threaded_eweasel")
					if Result = Void then
						if all_tests_added then
							print_debug_worker ("There are no more waiting tests in next_waiting_test")
						else
							print_debug_worker ("Not all tests have been added to queue in next_waiting_test")
						end
					end
				end
				if Result = Void and not no_tests then
					debug ("threaded_eweasel")
						print_debug_worker ("Waiting for more tests to be added in next_waiting_test")
					end
					more_waiting_tests.wait (mutex)
					debug ("threaded_eweasel")
						print_debug_worker ("Finished waiting for more tests to be added in next_waiting_test")
					end
				end
				mutex.unlock
				debug ("threaded_eweasel")
					print_debug_worker ("Unlocked mutex in next_waiting_test")
				end
			end
		end

	next_completed_test: detachable EW_NAMED_EIFFEL_TEST
			-- Next test that has been completed and can
			-- now be reported or Void if no more tests
		local
			entry: EW_EIFFEL_TEST_QUEUE_ENTRY
			more_tests: BOOLEAN
		do
			more_tests := True
			from
			until
				Result /= Void or not more_tests
			loop
				debug ("threaded_eweasel")
					print_debug_main ("Trying to lock mutex in next_completed_test")
				end
				mutex.lock
				debug ("threaded_eweasel")
					print_debug_main ("Locked mutex in next_completed_test")
				end
				more_tests := has_more_tests
				debug ("threaded_eweasel")
					if more_tests then
						print_debug_main ("Test queue is not empty in next_completed_test")
					else
						print_debug_main ("Test queue is empty in next_completed_test")
					end
				end
				if more_tests then
					if results_in_catalog_order then
						entry := pending_queue.first
						if not entry.waiting and not entry.in_use then
							-- First test in queue has completed
							Result := entry.test
							pending_queue.start
							pending_queue.remove
							debug ("threaded_eweasel")
								print_debug_main ({STRING_32} "Found completed test " + Result.last_source_directory_component + " in next_completed_test")
							end
						end
					elseif not completed_queue.is_empty then
						Result := completed_queue.first.test
						completed_queue.start
						completed_queue.remove
						debug ("threaded_eweasel")
							print_debug_main ({STRING_32} "Found completed test " + Result.last_source_directory_component + " in next_completed_test")
						end
					end
				end
				if Result = Void and more_tests then
					debug ("threaded_eweasel")
						print_debug_main ("Waiting for more completed tests in next_completed_test")
					end
					more_completed_tests.wait (mutex)
					debug ("threaded_eweasel")
						print_debug_main ("Finished waiting for more completed tests in next_completed_test")
					end
				end
				mutex.unlock
				debug ("threaded_eweasel")
					print_debug_main ("Unlocked mutex in next_completed_test")
				end
			end
		end

	set_all_tests_added
			-- Set `all_tests_added' to true
		do
			debug ("threaded_eweasel")
				print_debug_main ("Trying to lock mutex in set_all_tests_added")
			end
			mutex.lock
			debug ("threaded_eweasel")
				print_debug_main ("Locked mutex in set_all_tests_added")
			end
			all_tests_added := True
			debug ("threaded_eweasel")
				print_debug_main ("Broadcasting more waiting tests in set_all_tests_added")
			end
			more_waiting_tests.broadcast
			mutex.unlock
			debug ("threaded_eweasel")
				print_debug_main ("Unlocked mutex in set_all_tests_added")
			end
		end

	broadcast_all_tests_completed
			-- Broad "all tests completed" indication.
			-- This should not be needed but is
			-- included just in case
		do
			debug ("threaded_eweasel")
				print_debug_main ("Trying to lock mutex in broadcast_all_tests_completed")
			end
			mutex.lock
			debug ("threaded_eweasel")
				print_debug_main ("Locked mutex in broadcast_all_tests_completed")
			end
			-- Wake up any waiting threads
			debug ("threaded_eweasel")
				print_debug_main ("Broadcasting all tests completed in broadcast_all_tests_completed")
			end
			more_waiting_tests.broadcast
			mutex.unlock
			debug ("threaded_eweasel")
				print_debug_main ("Unlocked mutex in broadcast_all_tests_completed")
			end
		end

feature {NONE} -- Implementation

	has_more_tests: BOOLEAN
		do
			if results_in_catalog_order then
				Result := not pending_queue.is_empty
			else
				Result := not pending_queue.is_empty or not executing_queue.is_empty or not completed_queue.is_empty
			end
		end

	mutex: MUTEX
			-- Mutex to control access to `tests' and `waiting'

	more_waiting_tests: CONDITION_VARIABLE
			-- Condition variable which indicates that
			-- there may be more tests to execute

	more_completed_tests: CONDITION_VARIABLE
			-- Condition variable which indicates that
			-- there may be more completed tests

	pending_queue: ARRAYED_LIST [EW_EIFFEL_TEST_QUEUE_ENTRY]
			-- If `results_in_catalog_order', this is queue of
			-- tests that are either awaiting execution or
			-- that have been executed but whose status
			-- hasn't yet been reported.  Otherwise, it only
			-- contaings tests that are awaiting execution

	executing_queue: ARRAYED_LIST [EW_EIFFEL_TEST_QUEUE_ENTRY]
			-- If not `results_in_catalog_order', this is queue of
			-- tests that are currently executing
			-- Otherwise, it is empty (not used)

	completed_queue: ARRAYED_LIST [EW_EIFFEL_TEST_QUEUE_ENTRY]
			-- If not `results_in_catalog_order', this is
			-- queue of tests that are have completed but
			-- whose status has not yet been reported.
			-- Otherwise, it is empty (not used).

feature {NONE} -- Obsolete

	lock
			-- Lock `Current' to gain exclusive access to it
			-- (so other threads don't change it)
		do
			mutex.lock
		end

	unlock
			-- Unlock `Current' to allow other threads access
		do
			mutex.unlock
		end

note
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
