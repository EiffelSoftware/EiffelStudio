indexing
	description: "Objects that represent a Vision2 container inheriting EV_WIDGET_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_LIST_OBJECT

inherit
	GB_CONTAINER_OBJECT
		redefine
			object, display_object, add_child_object
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_WIDGET_LIST
		-- Vision2 object referenced by `Current'.
		-- This is used in the display window.
	
	display_object: GB_WIDGET_LIST_DISPLAY_OBJECT
		-- The display object used to represent `object'.
		-- This is used in the builder window.

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			widget: EV_WIDGET
			box: EV_BOX
		do
			widget ?= an_object.object
			object.go_i_th (position)
			object.put_left (widget)
			if not an_object.expanded_in_box then
					-- Update expanded state of `an_object'.
				box ?= object
				if box /= Void then
					box.disable_item_expand (widget)
				end
			end
			widget ?= an_object.display_object
			display_object.child.go_i_th (position)
			display_object.child.put_left (widget)
			if not an_object.expanded_in_box then
				 -- Update expanded state of `an_object'.
				box ?= display_object.child
				if box /= Void then
					box.disable_item_expand (widget)
				end
			end
			
				-- Perform special processing of `layout_item' children
				-- as locked instances must not show their children.
			if layout_item.data = Void then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)
			end
			add_child (an_object, position)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_WIDGET_LIST_OBJECT
