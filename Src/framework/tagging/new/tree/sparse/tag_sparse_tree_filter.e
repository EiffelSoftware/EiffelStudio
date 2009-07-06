note
	description: "Summary description for {TAG_SPARSE_TREE_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_SPARSE_TREE_FILTER [G -> TAG_ITEM]

feature {TAG_SPARSE_TREE} -- Query

	is_node_included (a_sparse_tree: TAG_SPARSE_TREE [G]; a_node: TAG_TREE_NODE [G]): TUPLE [BOOLEAN, BOOLEAN]
			-- Should node be included in sparse tree?
			--
			-- `a_sparse_tree': Sparse tree connected to tree.
			-- `a_node': A node in tree.
			-- `Result': Tuple containing two boolean. First boolean indicated whether `a_node' should be
			--           included in `a_sparse_tree'. Second indicates whether it is possible that `a_nodes'
			--           children return different results.
		require
			a_sparse_tree_attached: a_sparse_tree /= Void
			a_node_attached: a_node /= Void
			a_sparse_tree_connected: a_sparse_tree.is_connected
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = a_sparse_tree.tree
		deferred
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
end -- class TAG_SPARSE_TREE_UPDATER


