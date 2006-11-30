indexing
	description: "A queue of named Eiffel tests that can be extended %
		%by multiple threads and worked on by multiple threads"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "September 13, 2001"

class EIFFEL_TEST_QUEUE

create
	make

feature -- Creation

	make is
		do
			create mutex
			create queue.make (100)
			create more_waiting_tests.make
			create more_completed_tests.make
		end


feature -- Properties

	finished: BOOLEAN
			-- Has producer finished adding tests to
			-- the queue?
	
feature -- Modification

	extend (t: NAMED_EIFFEL_TEST) is
			-- Add `t' to end of list of tests
		local
			entry: EIFFEL_TEST_QUEUE_ENTRY
		do
			create entry.make (t)
			mutex.lock
			queue.extend (entry)
			more_waiting_tests.signal
			mutex.unlock
		end

	mark_test_completed (t: NAMED_EIFFEL_TEST) is
			-- Mark test `t' as completed (no longer awaiting
			-- execution)
		local
			done: BOOLEAN
			entry: EIFFEL_TEST_QUEUE_ENTRY
		do
			mutex.lock
			from
				queue.start
			until
				queue.after or done
			loop
				entry := queue.item
				if entry.test = t then
					entry.set_waiting (False)
					entry.set_in_use (False)
					done := True
				end
				queue.forth
			end
			more_completed_tests.signal
			mutex.unlock
		end

	next_waiting_test: NAMED_EIFFEL_TEST is
			-- Next test awaiting execution or Void if
			-- no more tests
		local
			no_tests: BOOLEAN
			entry: EIFFEL_TEST_QUEUE_ENTRY
		do
			from
				
			until
				Result /= Void or no_tests
			loop
				mutex.lock
				from
					queue.start
				until
					queue.after or Result /= Void
				loop
					entry := queue.item
					if entry.waiting and not entry.in_use then
						entry.set_in_use (True)
						Result := entry.test
					end
					queue.forth
				end
				no_tests := Result = Void and finished
				if Result = Void and not no_tests then
					more_waiting_tests.wait (mutex)
				end
				mutex.unlock
			end
		end

	next_completed_test: NAMED_EIFFEL_TEST is
			-- Next test that has been completed and can
			-- now be reported or Void if no more tests
		local
			entry: EIFFEL_TEST_QUEUE_ENTRY
			no_tests: BOOLEAN
		do
			from
			until
				Result /= Void or no_tests
			loop
				mutex.lock
				no_tests := queue.empty
				if not no_tests then
					entry := queue.first
					if not entry.waiting and not entry.in_use then
						Result := entry.test
						queue.start
						queue.remove
					end
				end
				if Result = Void and not no_tests then
					more_completed_tests.wait (mutex)
				end
				mutex.unlock
			end
		end

	set_finished is
			-- Set `finished' to true
		do
			finished := True
		end

feature {NONE} -- Implementation

	mutex: MUTEX
			-- Mutex to control access to `tests' and `waiting'

	more_waiting_tests: CONDITION_VARIABLE
			-- Condition variable which indicates that
			-- there may be more tests to execute

	more_waiting_tests_mutex: MUTEX
			-- Associated mutex

	more_completed_tests: CONDITION_VARIABLE
			-- Condition variable which indicates that
			-- there may be more completed tests

	more_completed_tests_mutex: MUTEX
			-- Associated mutex

	queue: ARRAYED_LIST [EIFFEL_TEST_QUEUE_ENTRY]
			-- Tests that are either awaiting execution or
			-- that have been executed but whose status
			-- hasn't yet been reported

feature {NONE} -- Obsolete

	lock is
			-- Lock `Current' to gain exclusive access to it
			-- (so other threads don't change it)
		do
			mutex.lock			
		end

	unlock is
			-- Unlock `Current' to allow other threads access
		do
			mutex.unlock			
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
