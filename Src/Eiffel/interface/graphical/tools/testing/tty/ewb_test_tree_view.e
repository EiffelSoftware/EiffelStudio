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
	EWB_TEST_FILTER_CMD

	TAG_UTILITIES
		export
			{NONE} all
		end

	EC_TAG_TREE_NODE_VISITOR [TEST_I]

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
			l_tree: like test_tree
			l_parent: TAG_TREE_NODE [TEST_I]
		do
			l_tree := test_tree (a_test_suite)
			l_parent := l_tree.common_parent
			if l_parent = l_tree.tree.root_node then
				print_node_container (l_tree, l_parent, 1)
			else
				print_string (indent)
				print_parents (l_parent)
				output_window.put_new_line
				print_node_container (l_tree, l_parent, 2)
			end
			print_statistics (a_test_suite)
		end

feature {NONE} -- Implementation

	print_parents (a_node: TAG_TREE_NODE [TEST_I])
			-- Print parents of `a_node'
		require
			a_node_attached: a_node /= Void
			a_node_not_root: not a_node.is_root
		local
			l_parent: like a_node
		do
			l_parent := a_node.parent
			if not l_parent.is_root then
				print_parents (l_parent)
				output_window.process_basic_text (" / ")
			end
			a_node.process (Current)
		end

	print_node_container (a_tree: like test_tree; a_node: TAG_TREE_NODE [TEST_I]; a_depth: INTEGER_32)
			-- Recursively print tag base tree node container
			--
			-- `a_tree': Tree for which nodes are being printed.
			-- `a_node': Node containing children to be printed.
			-- `a_depth': Current recursion depth.
		require
			a_node_attached: a_node /= Void
			a_depth_not_negative: a_depth >= 0
		local
			l_children: DS_ARRAYED_LIST [TAG_TREE_NODE [TEST_I]]
			l_child: TAG_TREE_NODE [TEST_I]
		do
			if a_node.is_leaf then
				print_test (a_node.item, a_depth)
			else
				l_children := a_node.children
				l_children.sort (node_sorter)

				from
					l_children.start
				until
					l_children.after
				loop
					l_child := l_children.item_for_iteration
					if a_tree.is_parent_node (l_child) or a_tree.is_inside_node (l_child) then
						if l_child.is_leaf then
							print_node_container (a_tree, l_child, a_depth)
						else
							print_multiple_string (indent, a_depth)
							l_child.process (Current)
							output_window.add_new_line
							print_node_container (a_tree, l_child, a_depth + 1)
						end
					end
					l_children.forth
				end
			end
		end

feature {TAG_TREE_NODE} -- Basic operations

	process_node (a_node: TAG_TREE_NODE [TEST_I])
			-- <Precursor>
		do
			if not a_node.is_root then
				output_window.process_basic_text (a_node.token.as_string_8)
			end
		end

	process_class_node (a_node: EC_TAG_TREE_CLASS_NODE [TEST_I])
			-- <Precursor>
		do
			if attached a_node.item (etest_suite.project_access) as l_class then
				output_window.add_class (l_class)
			end
		end

	process_cluster_node (a_node: EC_TAG_TREE_CLUSTER_NODE [TEST_I])
			-- <Precursor>
		do
			if attached a_node.item (etest_suite.project_access) as l_cluster then
				output_window.add_group (l_cluster, l_cluster.name)
			end
		end

	process_directory_node (a_node: EC_TAG_TREE_DIRECTORY_NODE [TEST_I])
			-- <Precursor>
		do
			if attached a_node.item (etest_suite.project_access) as l_cluster then
				output_window.add_group (l_cluster, a_node.name.as_string_8)
			end
		end

	process_feature_node (a_node: EC_TAG_TREE_FEATURE_NODE [TEST_I])
			-- <Precursor>
		do
			if attached a_node.item (etest_suite.project_access) as l_feature then
				output_window.add_feature (l_feature, l_feature.name)
			end
		end

	process_library_node (a_node: EC_TAG_TREE_LIBRARY_NODE [TEST_I])
			-- <Precursor>
		do
			if attached a_node.item (etest_suite.project_access) as l_library then
				output_window.add_group (l_library, l_library.name)
			end
		end

	process_override_node (a_node: EC_TAG_TREE_OVERRIDE_NODE [TEST_I])
			-- <Precursor>
		do
			if attached a_node.item (etest_suite.project_access) as l_override then
				output_window.add_group (l_override, l_override.name)
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
