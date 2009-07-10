note
	description: "[
		{ES_TAG_TREE_NODE} representing libraries of an Eiffel system.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAG_TREE_LIBRARY_NODE [G -> TAG_ITEM]

inherit
	ES_TAG_TREE_NODE [G, CONF_LIBRARY]
		rename
			make as make_es_node
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent; a_tag, an_item_name: READABLE_STRING_GENERAL; a_uuid: like uuid; a_tag_item: G)
			-- Initialize `Current' as a inner node.
			--
			-- `a_parent': Parent node for `Current'.
			-- `a_tag': Tag suffix to be represented by `Current' and it's new children.
			-- `an_item_name': Name for item.
			-- `a_uuid': UUID of the library.
			-- `a_tag_item': Item to be attached to leaf.
		require
			a_parent_attached: a_parent /= Void
			a_tag_attached: a_tag /= Void
			an_item_name_attached: an_item_name /= Void
			a_tag_item_attached: a_tag_item /= Void
			a_uuid_attached: a_uuid /= Void
			a_parent_active: a_parent.is_active
			a_tag_valid: a_parent.tree.validator.is_valid_tag (a_tag)
			an_item_name_valid: not an_item_name.is_empty
		do
			make_es_node (a_parent, a_tag, an_item_name, a_tag_item)
			uuid := a_uuid
		end

feature -- Access

	uuid: UUID
			-- UUID of the library

feature {NONE} -- Implementation

	process_ec_node (a_visitor: EC_TAG_TREE_NODE_VISITOR [G])
			-- <Precursor>
		do
			a_visitor.process_library_node (Current)
		end

	retrieve_item (a_project: EC_PROJECT_ACCESS): like item
			-- <Precursor>
		local
			l_list: LIST [CONF_LIBRARY]
			l_universe: UNIVERSE_I
			l_root_target: CONF_TARGET
		do
			l_universe := a_project.project.universe
			l_root_target := l_universe.target
			l_list := l_universe.library_of_uuid (uuid, True)
			from
				l_list.start
			until
				l_list.after
			loop
				if l_list.item_for_iteration.target = l_root_target or
				   l_list.item_for_iteration = l_list.last
				then
					Result := l_list.item_for_iteration
					l_list.finish
				end
				l_list.forth
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
