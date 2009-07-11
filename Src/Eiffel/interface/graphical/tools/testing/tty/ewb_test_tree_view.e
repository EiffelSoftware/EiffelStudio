note
	description: "[
		TTY command showing current tests in a tag based tree structure.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_TREE_VIEW

inherit
	EWB_TEST_CMD

	TAG_UTILITIES
		export
			{NONE} all
		end

feature -- Access

	name: STRING_8
			-- <Precursor>
		do
			Result := "Tree view"
		end

	abbreviation: CHARACTER
			-- <Precursor>
		do
			Result := 't'
		end

	help_message: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale.translation (h_display_tree)
		end

feature {NONE} -- Access

	node_sorter: DS_SORTER [TAG_BASED_TREE_NODE [TEST_I]]
			-- Sorter for {TAG_BASED_TREE_NODE}.
		local
			l_cache: like node_sorter_cache
			l_comparator: AGENT_BASED_EQUALITY_TESTER [TAG_BASED_TREE_NODE [TEST_I]]
			l_sorter: DS_QUICK_SORTER [TAG_BASED_TREE_NODE [TEST_I]]
		do
			l_cache := node_sorter_cache
			if l_cache = Void then
				create l_comparator.make (
					agent (a_node1, a_node2: TAG_BASED_TREE_NODE [TEST_I]): BOOLEAN
						do
							Result := a_node1.token < a_node2.token
						end)
				create l_sorter.make (l_comparator)
				node_sorter_cache := l_sorter
				Result := l_sorter
			else
				Result := l_cache
			end
		ensure
			result_attached: Result /= Void
		end

	node_sorter_cache: detachable like node_sorter
			-- Cache for `node_sorter'

	item_sorter: DS_SORTER [TEST_I]
			-- Sorter for {TEST_I}
		local
			l_cache: like item_sorter_cache
			l_comparator: AGENT_BASED_EQUALITY_TESTER [TEST_I]
			l_sorter: DS_QUICK_SORTER [TEST_I]
		do
			l_cache := item_sorter_cache
			if l_cache = Void then
				create l_comparator.make (
					agent (a_test1, a_test2: TEST_I): BOOLEAN
						do
							Result := a_test1.name < a_test2.name
						end)
				create l_sorter.make (l_comparator)
				item_sorter_cache := l_sorter
				Result := l_sorter
			else
				Result := l_cache
			end
		ensure
			result_attached: Result /= Void
		end

	item_sorter_cache: detachable like item_sorter
			-- Cache for `node_sorter'

feature {NONE} -- Query

	is_prefixed_token (a_token, a_prefix: STRING): BOOLEAN
			-- Does token represent token with given prefix?
		do
			Result := a_token.starts_with (a_prefix) and a_token.count > a_prefix.count
		end

feature {NONE} -- Basic operations

	execute_with_test_suite (a_test_suite: TEST_SUITE_S)
			-- <Precursor>
		local
			l_view: like tree_view
			l_items: DS_ARRAYED_LIST [TEST_I]
		do
			print_current_expression (a_test_suite, False)
			print_current_prefix (a_test_suite, False)

			l_view := tree_view (a_test_suite)
			if not l_view.children.is_empty or not l_view.items.is_empty then
				print_string ("%N")
			end
			print_node_container (l_view, 0)

			create l_items.make_from_linear (l_view.untagged_items)
			if not l_items.is_empty then
				print_string ("%N")
				print_string (locale.translation (t_untagged_tests))
				print_string ("%N")
				l_items.sort (item_sorter)
				l_items.do_all (agent print_test (?, "+ ", tab_count))
			end

			print_statistics (a_test_suite, True)
		end

feature {NONE} -- Implementation

	print_node_container (a_node: TAG_BASED_TREE_NODE_CONTAINER [TEST_I]; a_depth: NATURAL)
			-- Recursively print tag base tree node container
			--
			-- `a_node': Node containing children to be printed.
			-- `a_depth': Current recursion depth.
		require
			a_node_attached: a_node /= Void
		local
			l_nodes: DS_ARRAYED_LIST [TAG_BASED_TREE_NODE [TEST_I]]
			l_child: TAG_BASED_TREE_NODE [TEST_I]
			l_items: DS_ARRAYED_LIST [TEST_I]
		do
			create l_nodes.make_from_linear (a_node.children)
			if not l_nodes.is_empty then
				l_nodes.sort (node_sorter)
				from
					l_nodes.start
				until
					l_nodes.after
				loop
					l_child := l_nodes.item_for_iteration
					print_node (l_child, a_depth)
					print_node_container (l_child, a_depth + 1)
					l_nodes.forth
				end
			end
			create l_items.make_from_linear (a_node.items)
			if not l_items.is_empty then
				l_items.sort (item_sorter)
				l_items.do_all (agent print_indented_test (?, a_depth))
			end
		end

	print_node (a_node: TAG_BASED_TREE_NODE [TEST_I]; a_depth: NATURAL)
			-- Print node information.
			--
			-- `a_node': Node for which information is printed.
		do
			print_multiple_string (" ", indent_count * a_depth.to_integer_32)
			print_token (a_node.token)
			print_string ("%N")
		end

	print_indented_test (a_test: TEST_I; a_depth: NATURAL)
			-- Print test with indentation.
			--
			-- `a_test': Test to be printed.
			-- `a_depth': Depth used for indentation.
		require
			a_test_attached: a_test /= Void
		local
			l_indent, l_tab: INTEGER
		do
			l_indent := a_depth.to_integer_32
			l_tab := (indent_count * l_indent).min (tab_count)
			print_multiple_string (" ", l_tab)
			print_test (a_test, "+ ", tab_count - l_tab)
		end

	print_token (a_token: STRING)
			-- Print information represented by token.
			--
			-- `a_token': Token to be printed.
		require
			a_token_attached: a_token /= Void
		local
			l_type: detachable STRING
			l_is_class, l_is_library: BOOLEAN
			l_token: STRING
			l_count, l_pos: INTEGER
		do
			if is_prefixed_token (a_token, cluster_prefix) then
				l_type := "Cluster"
				l_count := cluster_prefix.count
			elseif is_prefixed_token (a_token, class_prefix) then
				l_is_class := True
				l_count := class_prefix.count
			elseif is_prefixed_token (a_token, feature_prefix) then
				l_type := "Feature"
				l_count := feature_prefix.count
			elseif is_prefixed_token (a_token, override_prefix) then
				l_type := "Override"
				l_count := override_prefix.count
			elseif is_prefixed_token (a_token, library_prefix) then
				l_type := "Library"
				l_count := library_prefix.count
				l_is_library := True
			elseif is_prefixed_token (a_token, directory_prefix) then
				l_count := directory_prefix.count
			end
			if l_count > 0 then
				l_token := a_token.substring (l_count + 1, a_token.count)
				if l_is_library then
					l_pos := l_token.index_of (':', 1)
					if l_pos > 0 then
						l_token := l_token.substring (1, l_pos)
					end
				end
			else
				l_token := a_token
			end
			if l_is_class then
				print_string ("{")
			end
			print_string (l_token)
			if l_is_class then
				print_string ("}")
			end
			if l_type /= Void then
				print_string (" (")
				print_string (l_type)
				print_string (")")
			end
		end

feature {NONE} -- Constants

	indent_count: INTEGER = 4

feature {NONE} -- Internationalization

	t_untagged_tests: STRING = "Tests not containing prefix:"

	h_display_tree: STRING = "Display tests in a tree structure"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
