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
		rename
			name as tag_name
		end

	TAGABLE_I
		redefine
			memento
		end

feature -- Access

	name: STRING
			-- Name of the test routine
		deferred
		end

	class_name: STRING
			-- Name of class in which `Current' is defined
		require
			usable: is_interface_usable
		deferred
		end

	outcomes: DS_BILINEAR [like last_outcome]
			-- Test results from passed executions where the last is the most recent one.
		require
			usable: is_interface_usable
		deferred
		end

	last_outcome: EQA_TEST_RESULT
			-- Last test result if `Current' has been tested
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last
		ensure
			result_is_last: Result = outcomes.last
		end

	executor: TEST_EXECUTOR_I
			-- Executor running `Current' or having `Current' queued.
		require
			queued_or_running: is_queued or is_running
		deferred
		end

	memento: TEST_MEMENTO_I
			-- <Precursor>
		deferred
		end

feature -- Access

	frozen tag_name: STRING
			-- <Precursor>
		local
			l_cache: like tag_name_cache
		do
			l_cache := tag_name_cache
			if l_cache = Void then
				create l_cache.make (class_name.count + name.count + 1)
				l_cache.append (class_name)
				l_cache.append_character ('.')
				l_cache.append (name)
				tag_name_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Access

	tag_name_cache: detachable like tag_name
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

feature {TEST_PROJECT_I} -- Status setting

	set_explicit_tags (a_list: like tags)
			-- Set tags in list to be explicit tags of `Current'
		require
			usable: is_interface_usable
			a_list_valid: a_list.for_all (agent is_valid_tag)
			not_a_list_has_empty: not a_list.there_exists (agent {STRING}.is_empty)
		deferred
		ensure
			tags_contains_list: a_list.for_all (agent tags.has)
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
