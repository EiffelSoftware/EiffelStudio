note
	description: "[
					EiffelRibbon tool helper features collection
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_HELPER

feature -- Command

	expand_all (a_tree: EV_TREE)
			-- Expand all tree items in `a_tree'
		local
			l_item: EV_TREE_NODE
		do
			from
				a_tree.start
			until
				a_tree.after
			loop
				l_item := a_tree.item_for_iteration
				if l_item.is_expandable then
					l_item.expand
				end
				expand_all_imp (l_item)
				a_tree.forth
			end
		end

feature {NONE} -- Implementation

	expand_all_imp (a_tree_node: EV_TREE_NODE)
			-- Implementation of `expand_all'
		local
			l_item: EV_TREE_NODE
		do
			from
				a_tree_node.start
			until
				a_tree_node.after
			loop
				l_item := a_tree_node.item_for_iteration
				if l_item.is_expandable then
					l_item.expand
					expand_all_imp (l_item)
				end

				a_tree_node.forth
			end
		end
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
