note
	description: "Summary description for {EC_TAG_TREE_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EC_TAG_TREE_NODE [G -> TAG_ITEM, H]

inherit
	TAG_TREE_NODE [G]
		rename
			item as tag_item
		redefine
			remove_internal,
			process
		end

feature {NONE} -- Initialization

	make (a_parent: like parent; a_tag, an_item_name: READABLE_STRING_GENERAL; a_tag_item: G)
			-- Initialize `Current' as a inner node.
			--
			-- `a_parent': Parent node for `Current'.
			-- `a_tag': Tag suffix to be represented by `Current' and it's new children.
			-- `an_item_name': Name for `item'.
			-- `a_tag_item': Item to be attached to leaf.
		require
			a_parent_attached: a_parent /= Void
			a_tag_attached: a_tag /= Void
			an_item_name_attached: an_item_name /= Void
			a_tag_item_attached: a_tag_item /= Void
			a_parent_active: a_parent.is_active
			a_tag_valid: a_parent.tree.validator.is_valid_tag (a_tag)
			an_item_name_valid: not an_item_name.is_empty
		do
			make_node (a_parent, a_tag, a_tag_item)
			name := tree.validator.immutable_string (an_item_name)
		ensure
			active: is_active
			valid_token: token.same_string (tree.formatter.first_token (a_tag))
			name_set: name.same_string_general (an_item_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_8
			-- Name for `item'

	item (a_project: EC_PROJECT_ACCESS): detachable H
			-- Item represented by `Current'
		require
			a_project_attached: a_project /= Void
			active: is_active
			not_root: not is_root
		do
			Result := item_cache
			if Result = Void or a_project.revision /= revision then
				if a_project.is_initialized then
					Result := retrieve_item (a_project)
					revision := a_project.revision
				end
				item_cache := Result
			end
		ensure

		end

feature {NONE} -- Access

	revision: NATURAL
			-- Revision of `item_cache'

	item_cache: like item
			-- Cache for `item'

feature {NONE} -- Removal

	remove_internal
			-- <Precursor>
		do
			if attached item_cache as l_cache then
				item_cache := l_cache.default
			end
		end

feature -- Basic operations

	frozen process (a_visitor: TAG_TREE_NODE_VISITOR [G])
			-- <Precursor>
		do
			if attached {EC_TAG_TREE_NODE_VISITOR [G]} a_visitor as l_visitor then
				process_ec_node (l_visitor)
			else
				Precursor (a_visitor)
			end
		end

feature {NONE} -- Implementation

	process_ec_node (a_visitor: EC_TAG_TREE_NODE_VISITOR [G])
			-- Process `Current' through a {EC_TAG_TREE_NODE_VISITOR}
			--
			-- `a_vistor': EC node visitor.
		deferred
		end

	retrieve_item (a_project: EC_PROJECT_ACCESS): like item
			-- Recompute `item' from given project.
			--
			-- `a_project': Project from which `item' should be retrieved.
		require
			a_project_attached: a_project /= Void
			active: is_active
			not_root: not is_root
			a_project_available: a_project.is_initialized
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
end
