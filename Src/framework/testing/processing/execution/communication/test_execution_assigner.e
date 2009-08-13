note
	description: "[
		Object assigning test indices to clients which then execute the corresponding test.
		Since tests are executed in separate threads, mutexes are used to controll access.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	TEST_EXECUTION_ASSIGNER

create
	make

feature {NONE} -- Initialization

	make (a_test_count: like test_count)
			-- Initialize `Current'.
			--
			-- `a_test_count': Number of tests that will be executed, where each test is identified through
			--                 a unique index between 1 and `a_test_count'.
		do
			test_count := a_test_count
			create cursor_mutex.make
			create aborted_tests.make_default
		ensure
			test_count_set: test_count = a_test_count
		end

feature -- Access

	test_count: NATURAL
			-- Number of tests being executed
			--
			-- Note: Each test is identified by a unique index between 1 and `test_count'. However it is up
			--       to the client to make the association.

feature {NONE} -- Access

	cursor: like test_count
			-- Index of last test that has been launched

	cursor_mutex: MUTEX
			-- Mutex for controlling access to `cursor' and `aborted_tests'.

	aborted_tests: DS_HASH_SET [like test_count]
			-- Indices of tests that have been aborted

feature {TEST_EVALUATOR_STATUS} -- Query

	has_next: BOOLEAN
			-- Are there any tests left to be executed?
		local
			l_cursor: like cursor
		do
			cursor_mutex.lock
			if cursor <= test_count then
				from
					l_cursor := cursor + 1
				until
					Result or l_cursor > test_count
				loop
					Result := aborted_tests.has (l_cursor)
					l_cursor := l_cursor + 1
				end
			end
			cursor_mutex.unlock
		end

	next_test: like test_count
			-- Index of next test to be executed, zero if tests have been executed.
			--
			-- Note: calling this routine will move the cursor forth.
		do
			cursor_mutex.lock
			if cursor <= test_count then
				from
				until
					Result > 0 or cursor > test_count
				loop
					cursor := cursor + 1
					if cursor <= test_count then
						if not aborted_tests.has (cursor) then
							Result := cursor
						end
					end
				end
			end
			cursor_mutex.unlock
		ensure
			a_test_index_valid: Result >= 0 and then Result <= test_count
		end

feature -- Status report

	is_aborted (a_test_index: like test_count): BOOLEAN
			-- Has test for given index been aborted?
			--
			-- `a_test_index': Index of test for which we want to know whether it has been aborted.
			-- `Result': True if test for given index has been aborted, False otherwise.
		require
			a_test_index_valid: a_test_index > 0 and then a_test_index <= test_count
		do
			cursor_mutex.lock
			Result := aborted_tests.has (a_test_index)
			cursor_mutex.unlock
		end

feature {TEST_OBSOLETE_EXECUTOR_I} -- Status setting

	set_aborted (a_test_index: like test_count)
			-- Add index of test to list of aborted tests.
			--
			-- `a_test_index': Index of test that has been aborted.
		require
			a_test_index_valid: a_test_index > 0 and then a_test_index <= test_count
		do
			cursor_mutex.lock
			aborted_tests.force_last (a_test_index)
			cursor_mutex.unlock
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
