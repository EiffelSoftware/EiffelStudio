indexing
	description: "Tree item representations of type selector items"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TREE_TYPE_SELECTOR_ITEM

inherit
	GB_TYPE_SELECTOR_ITEM
		redefine
			item
		end

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', assign `a_text' to `text'
			-- , "EV_" + `a_text' to `type' and `a_components' to `components'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			components := a_components
			create item.make_with_text (a_text)
			item.set_data (Current)
			type := "EV_" + a_text
				-- We must now add the correct pixmap.
			create pixmaps
			item.set_pixmap (pixmaps.pixmap_by_name (type.as_lower))
			item.set_pebble_function (agent generate_transportable)
			item.drop_actions.extend (agent replace_layout_item (?))
			item.drop_actions.set_veto_pebble_function (agent can_drop_object)
		end

feature -- Access

	item: EV_TREE_ITEM
		-- Graphical representation of `Current' used in the type selector.

feature {NONE} -- Implementation

	process_number_key is
			-- Begin processing by `digit_checker', so that
			-- it can be determined if a digit key is held down.
		local
			tree: EV_TREE
			tree_node: EV_TREE_NODE_LIST
		do
			from
				tree_node := item
			until
				tree /= Void
			loop
				tree_node ?= tree_node.parent
				tree ?= tree_node
			end
			components.digit_checker.begin_processing (tree)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_TREE_TYPE_SELECTOR_ITEM
