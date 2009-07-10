note
	description: "[
		Factory responsible for creating nodes being used in a TAG_TREE.

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE_NODE_FACTORY [G -> TAG_ITEM]

feature -- Factory

	create_node (a_parent: TAG_TREE_NODE [G]; a_tag: READABLE_STRING_GENERAL; an_item: G): TAG_TREE_NODE [G]
			-- Create new inner node.
			--
			-- `a_parent': Parent of new node.
			-- `a_tag': Tag suffix to be represented by `Current' and it's new children.
			-- `an_item': Item to be attached to new leaf.
		require
			a_parent_attached: a_parent /= Void
			a_tag_attached: a_tag /= Void
			an_item_attached: an_item /= Void
			a_parent_active: a_parent.is_active
			a_tag_valid: a_parent.tree.validator.is_valid_tag (a_tag)
		do
			create Result.make_node (a_parent, a_tag, an_item)
		ensure
			result_attached: Result /= Void
		end

	create_root_node (a_tree: TAG_TREE [G]): TAG_TREE_NODE [G]
			-- Create new root node.
			--
			-- `a_tree': Tree in which new node will be root.
		require
			a_tree_attached: a_tree /= Void
		do
			create Result.make_root (a_tree)
		ensure
			result_attached: Result /= Void
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
