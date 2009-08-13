note
	description: "[
		Interface of a test that can be executed and contains a list of outcomes resulting from passed
		executions.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_I

inherit
	TAG_ITEM

-- OBSOLETE ANCESTORS

	TAGABLE_I
		rename
			name as routine_name
		export
			{TEST_SUITE_S} clear_changes
		redefine
			memento
		end

feature -- Access

	frozen name: IMMUTABLE_STRING_8
			-- <Precursor>
			--
			-- Note: this will be replaced by `routine_name'
		local
			l_name: STRING
			l_cache: like name_cache
		do
			l_cache := name_cache
			if l_cache = Void then
				create l_name.make (class_name.count + routine_name.count + 1)
				l_name.append (class_name)
				l_name.append_character ('.')
				l_name.append (routine_name.as_string_8)
				l_cache := l_name
				name_cache := l_cache
			end
			Result := l_cache
		end

feature -- Access

	routine_name: READABLE_STRING_GENERAL
			-- Unique name for `Current'.
			--
			-- Note: since name is used for `hash_code' and also to identify tests in {TEST_SUITE_S} it
			--       should remain constant for `Current'.
		deferred
		end

	last_outcome: EQA_RESULT
			-- Last test result if `Current' has been tested
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last
		ensure
			result_is_last: Result = outcomes.last
		end

	outcomes: DS_BILINEAR [like last_outcome]
			-- Test results from passed executions where the last is the most recent one.
		require
			usable: is_interface_usable
		deferred
		end

feature -- Status report

	is_outcome_available: BOOLEAN
			-- Has `Current' been executed yet?
		require
			usable: is_interface_usable
		do
			Result := not outcomes.is_empty
		ensure
			definition: Result = not outcomes.is_empty
		end

	passed: BOOLEAN
			-- Has `Current' passed the last execution?
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last.is_pass
		end

	failed: BOOLEAN
			-- Has `Current' failed the last execution?
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last.is_fail
		end

feature -- Basic operations

	print_test (a_formatter: TEXT_FORMATTER)
			-- Print formatted output for `Current' on a single line.
			--
			-- `a_formatter': Formatter to which output should be printed to.
		do
			a_formatter.process_basic_text (name.as_string_8)
		end

	print_result (a_formatter: TEXT_FORMATTER; a_result: EQA_RESULT)
			-- Print formatted result information for given result.
			--
			-- Note: descendants which are aware of specialized output should redefine to provide more
			--       information on `a_result' by doing an object test.
			--
			-- `a_formatted': Formatter to which output should be printed to.
		do
			if a_result.is_pass then
				a_formatter.process_basic_text ("pass")
			else
				if a_result.is_fail then
					a_formatter.process_basic_text ("FAIL")
				else
					a_formatter.process_basic_text ("unresolved")
				end
				if not a_result.tag.is_empty then
					a_formatter.process_basic_text (" (")
					a_formatter.process_basic_text (a_result.tag.as_string_8)
					a_formatter.process_basic_text (")")
				end
			end
		end

feature {TEST_EXECUTION_I} -- Factory

	new_executor (an_execution: TEST_EXECUTION_I): TEST_EXECUTOR_I [TEST_I]
			-- Create a new executor for running `Current' in the given session.
			--
			-- `an_execution': Execution session in which `Current' should be executed.
		require
			an_execution_attached: an_execution /= Void
			an_execution_usable: an_execution.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
			result_valid: Result.is_test_compatible (Current)
		end



-- OBSOLETE FEATURES

feature -- Access

	class_name: STRING
			-- Name of class in which `Current' is defined
		require
			usable: is_interface_usable
		deferred
		end

	executor: TEST_OBSOLETE_EXECUTOR_I
			-- Executor running `Current' or having `Current' queued.
		require
			queued_or_running: is_queued or is_running
		deferred
		end

feature {NONE} -- Access

	name_cache: detachable like name
			-- Cache for `tag_name'

feature -- Status report

	is_queued: BOOLEAN
			-- Is some implementation about to be tested by `Current'?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_not_running: Result implies not is_running
		end

	is_running: BOOLEAN
			-- Is some implementation beeing tested by `Current'?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_not_queued: Result implies not is_queued
		end

feature {TEST_SUITE_S} -- Status setting

	set_queued (a_executor: like executor)
			-- Set `Current' to be queued by an executor
			--
			-- `a_executor': Executor set to run `Current'.
		require
			usable: is_interface_usable
			not_active: not (is_queued or is_running)
		deferred
		ensure
			queued: is_queued
			changed: has_changed
			executor_set: executor = a_executor
		end

	set_running
			-- Set `is_running' to True.
		require
			usable: is_interface_usable
			queued: is_queued
		deferred
		ensure
			running: is_running
			changed: has_changed
		end

	abort
			-- Set `is_queued' and `is_running' to False.
		require
			usable: is_interface_usable
			active: is_queued or is_running
		deferred
		ensure
			not_active: not (is_queued or is_running)
			changed: has_changed
		end

	add_outcome (a_outcome: like last_outcome)
			-- Add outcome to end of outcomes list.
			--
			-- `a_outcome': Outcome to be added to the end of `outcomes'.
		require
			usable: is_interface_usable
			active: is_running
		deferred
		ensure
			outcome_available: is_outcome_available
			a_outcome_last: last_outcome = a_outcome
			not_active: not (is_queued or is_running)
			changed: has_changed
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
