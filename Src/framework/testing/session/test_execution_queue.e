note
	description: "[
		Objects representing a set of test groups which can be executed by the same executor.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTION_QUEUE

create {TEST_EXECUTION}
	make

feature {NONE} -- Initialization

	make (an_executor: like executor)
			-- Initialize `Current'.
		require
			an_executor_attached: an_executor /= Void
			an_executor_usable: an_executor.is_interface_usable
		do
			executor := an_executor
			create group_map.make (10)
		end

feature -- Access

	executor: TEST_EXECUTOR_I [TEST_I]
			-- Executor capable of executing test groups in `group_map'

	group_map: HASH_TABLE [SEARCH_TABLE [TEST_I], NATURAL_64]
			-- Table mapping execution groups to the their corresponding tests.
			--
			-- Note: an execution group is identified through a {NATURAL_64} bit pattern.
			--
			-- keys: Group identifier
			-- values: Hash tables containing tests belonging to group

feature -- Status report

	has_test (a_test: TEST_I): BOOLEAN
			-- Does `group_map' contain given test in one of its test sets?
		require
			a_test_attached: a_test /= Void
		local
			l_group_map: like group_map
		do
			from
				l_group_map := group_map
				l_group_map.start
			until
				l_group_map.after or Result
			loop
				Result := l_group_map.item_for_iteration.has (a_test)
				l_group_map.forth
			end
		end

feature -- Basic operations

	add_test (a_test: TEST_I; a_group: NATURAL_64)
			-- Add test to `group_map' under given group.
			--
			-- `a_test': Test to be added.
			-- `a_group': Group id to which test should be added.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
			a_test_compatible: executor.is_test_compatible (a_test)
		local
			l_map: like group_map
			l_test_set: SEARCH_TABLE [TEST_I]
		do
			l_map := group_map
			l_map.search (a_group)
			if l_map.found then
				l_test_set := l_map.found_item
			else
				create l_test_set.make (10)
				l_map.force (l_test_set, a_group)
			end
			l_test_set.force (a_test)
		end

invariant
	executor_attached: executor /= Void
	group_map_attached: group_map /= Void
	executor_usable: executor.is_interface_usable

	group_map_valid: group_map.linear_representation.for_all (
		agent (a_set: SEARCH_TABLE [TEST_I]): BOOLEAN
			do
				Result := not a_set.is_empty and a_set.linear_representation.for_all (
					agent (a_test: TEST_I): BOOLEAN
						do
							Result := a_test.is_interface_usable and then executor.is_test_compatible (a_test)
						end)
			end)

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
