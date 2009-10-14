note
	description: "Summary description for {EWB_TEST_FILTER_CMD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EWB_TEST_FILTER_CMD

inherit
	EWB_TEST_CMD
		redefine
			check_arguments_and_execute
		end

feature {NONE} -- Access

	sort_nodes (a_container: INDEXABLE [TAG_TREE_NODE [TEST_I], INTEGER])
			-- Sort nodes in container using quick sort.
		local
			l_sorter: QUICK_SORTER [TAG_TREE_NODE [TEST_I]]
			l_comparator: AGENT_EQUALITY_TESTER [TAG_TREE_NODE [TEST_I]]
		do
			create l_comparator.make (
				agent (a_node1, a_node2: TAG_TREE_NODE [TEST_I]): BOOLEAN
						do
							Result := a_node1.token < a_node2.token
						end)
			create l_sorter.make (l_comparator)
			l_sorter.sort (a_container)
		end

	node_sorter: DS_QUICK_SORTER [TAG_TREE_NODE [TEST_I]]
			-- Sorter for {TAG_BASED_TREE_NODE}.
		local
			l_comparator: AGENT_BASED_EQUALITY_TESTER [TAG_TREE_NODE [TEST_I]]
		do
			if attached node_sorter_cache as l_result then
				Result := l_result
			else
				create l_comparator.make (
					agent (a_node1, a_node2: TAG_TREE_NODE [TEST_I]): BOOLEAN
						do
							Result := a_node1.token < a_node2.token
						end)
				create Result.make (l_comparator)
				node_sorter_cache := Result
			end
		ensure
			result_attached: Result /= Void
			result_cached: Result = node_sorter_cache
		end

	sort_items (a_container: INDEXABLE [TEST_I, INTEGER])
			-- Sort items in container using quick sort.
		local
			l_sorter: QUICK_SORTER [TEST_I]
			l_comparator: AGENT_EQUALITY_TESTER [TEST_I]
		do
			create l_comparator.make (
				agent (a_test1, a_test2: TEST_I): BOOLEAN
						do
							Result := a_test1.name < a_test2.name
						end)
			create l_sorter.make (l_comparator)
			l_sorter.sort (a_container)
		end

	item_sorter: DS_QUICK_SORTER [TEST_I]
			-- Sorter for {TEST_I}.
			--
			-- Note: this sorter also takes class names in account.
		local
			l_comparator: AGENT_BASED_EQUALITY_TESTER [TEST_I]
		do
			if attached item_sorter_cache as l_result then
				Result := l_result
			else
				create l_comparator.make (
					agent (a_test1, a_test2: TEST_I): BOOLEAN
						do
							Result := a_test1.name < a_test2.name
						end)
				create Result.make (l_comparator)
				item_sorter_cache := Result
			end
		ensure
			result_attached: Result /= Void
			result_cached: Result = item_sorter_cache
		end

	node_sorter_cache: detachable like node_sorter
	item_sorter_cache: detachable like item_sorter
			-- Sorter caches

feature {NONE} -- Basic operations

	check_arguments_and_execute
			-- Use any arguments as a new filter and further execute the command.
			--
			-- Note: this is a replacement for `check_arguments_and_execute' which is used by some testing
			--       commands.
		local
			l_expr: STRING
			l_io: like command_line_io
			l_reset: BOOLEAN
		do
			create l_expr.make (100)
			from
				l_io := command_line_io
			until
				not l_io.more_arguments
			loop
				if l_reset then
					l_expr.append_character (' ')
				else
					l_reset := True
				end
				l_expr.append (l_io.command_arguments.current_item)
			end
			if l_reset then
				if attached test_tree_cache as l_test_tree then
					if l_test_tree.is_connected then
						l_test_tree.disconnect
					end
				end
				test_tree_filter.set_expression (l_expr)
			end
			Precursor
			node_sorter_cache := Void
			item_sorter_cache := Void
		end

	print_test_list (a_list: SEARCH_TABLE [TEST_I]; a_indent: INTEGER_32)
			-- Print list of tests.
		require
			a_list_attached: a_list /= Void
			a_indent_not_negative: a_indent >= 0
		local
			l_list: ARRAYED_LIST [TEST_I]
		do
			l_list := a_list.linear_representation
			sort_items (l_list)
			l_list.do_all (agent print_test (?, a_indent))
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
