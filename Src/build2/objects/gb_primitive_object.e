indexing
	description: "GB_OBJECT representing an EV_PRIMITIVE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PRIMITIVE_OBJECT

inherit
	GB_PARENT_OBJECT
		redefine
			object, display_object
		end

create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_PRIMITIVE
		-- The vision2 object that `Current' represents.
	
	display_object: EV_PICK_AND_DROPABLE
		-- The representation of `object' used in `build_window'.
		
feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			list: EV_ITEM_LIST [EV_ITEM]
			item: EV_ITEM
		do
			list ?= object
			item ?= an_object.object
			list.go_i_th (position)
			list.put_left (item)
				-- Check we need to handle if display_object is a container.
			list ?= display_object
			item ?= an_object.display_object
			list.go_i_th (position)
			list.put_left (item)
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


end -- class GB_CONTAINER_OBJECT
