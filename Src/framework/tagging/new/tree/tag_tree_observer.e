note
	description: "Summary description for {TAG_TREE_OBSERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE_OBSERVER [G -> TAG_ITEM]

inherit
	TAG_SERVER_OBSERVER [G]

feature {TAG_TREE} -- Events

	on_node_added (a_tree: TAG_TREE [G]; a_node: TAG_TREE_NODE [G])
		require
			a_tree_attached: a_tree /= Void
			a_node_attached: a_node /= Void
			a_node_valid: a_node.is_active and then a_node.tree = a_tree
			a_node_not_root: not a_node.is_root
		do

		end

	on_node_remove (a_tree: TAG_TREE [G]; a_node: TAG_TREE_NODE [G])
		require
			a_tree_attached: a_tree /= Void
			a_node_attached: a_node /= Void
			a_node_valid: a_node.is_active and then a_node.tree = a_tree
			a_node_not_root: not a_node.is_root
		do

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
