note
	description: "[
		Objects that represent a child node in {TAG_BASED_TREE}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_BASED_TREE_NODE [G -> TAGABLE_I]

inherit
	TAG_BASED_TREE_NODE_CONTAINER [G]
		rename
			make as make_container
		redefine
			token,
			parent
		end

create {TAG_BASED_TREE_NODE_CONTAINER}
	make

feature {NONE} -- Initialization

	make (a_parent: like parent; a_token: like token)
			-- Initialize `Current'.
			--
			-- `a_parent': Parent node for `Current'.
			-- `a_token': Token which `Current' will represent in tree.
		require
			a_parent_active: a_parent.is_interface_usable
			a_token_valid: is_valid_token (a_token)
		do
			make_container
			parent := a_parent
			create token.make_from_string (a_token)
			tag := join_tags (parent.tag, token)
			tree := a_parent.tree
		ensure
			parent_set: parent = a_parent
			token_set: token.is_equal (a_token)
			not_evaluated: not is_evaluated
			empty: is_empty
		end

feature -- Access

	token: STRING
			-- Token `Current' represents in the tag

	tag: STRING
			-- Tag defining ancestors of `Current'

	parent: TAG_BASED_TREE_NODE_CONTAINER [G]
			-- Node listing `Current' as one of its children

	data: detachable ANY
			-- Storage for arbitrary data assocaited with `token'

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Access

	tree: TAG_BASED_TREE [G]
			-- <Precursor>

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := parent.is_interface_usable and then
				parent.children.has (Current)
		end

	is_root: BOOLEAN = False
			-- <Precursor>

feature -- Status setting

	set_data (a_data: like data)
			-- Set `data' to `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

invariant
	tag_correct: is_interface_usable implies tag.is_equal (join_tags (parent.tag, token))

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
