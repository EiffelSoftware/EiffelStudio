note
	description: "Summary description for {TAG_TREE_NODE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_TREE_NODE_VISITOR [G -> TAG_ITEM]

feature {TAG_TREE_NODE} -- Basic operations

	process_node (a_node: TAG_TREE_NODE [G])
			-- Process basic node type.
			--
			-- `a_node': Node to be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		deferred
		end

feature {NONE} -- Basic operations

	frozen process_children (a_node: TAG_TREE_NODE [G])
			-- Process all children in given node.
			--
			-- `a_node': Node for which's children should be processed.
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
		local
			l_cursor: DS_LINEAR_CURSOR [TAG_TREE_NODE [G]]
			l_node: TAG_TREE_NODE [G]
		do
			if not a_node.is_leaf then
				from
					l_cursor := a_node.children.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					l_node := l_cursor.item
					if l_node.is_active then
						l_node.process (Current)
					end
					l_cursor.forth
				end
			end
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
