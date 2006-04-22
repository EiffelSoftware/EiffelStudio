indexing
	description: "Objects that represent an EiffelBuild menu bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_MENU_BAR_OBJECT

inherit
	GB_PARENT_OBJECT
		redefine
			object, display_object, accepts_child, is_full
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_MENU_BAR
		-- A representation of `Current' used
		-- in the display_window.

	display_object: EV_MENU_BAR
		-- A representation of `Current' used
		-- in the builder_window

	is_full: BOOLEAN is
			-- `Current' is never full.
			-- Always room for one more menu item.
		do
			Result := False
		end


feature {GB_OBJECT_HANDLER} -- Implementation

	accepts_child (a_type: STRING): BOOLEAN is
			-- Does `Current' accept `an_object'. By default,
			-- widgets are accepted. Redefine in primitives
			-- that must hold items to allow insertion.
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_string)) or
				type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_item_string)) then
				Result := True
			end
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			menu_item: EV_MENU_ITEM
		do
			menu_item ?= an_object.object
			check
				object_is_a_menu_item: menu_item /= Void
			end
			object.go_i_th (position)
			object.put_left (menu_item)
			menu_item ?= an_object.display_object
			check
				display_object_is_a_menu_item: menu_item /= Void
			end
			display_object.go_i_th (position)
			display_object.put_left (menu_item)
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


end -- class GB_MENU_BAR_OBJECT
