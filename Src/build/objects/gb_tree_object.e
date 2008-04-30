indexing
	description: "GB_OBJECT representing an EV_TREE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TREE_OBJECT

inherit
	GB_PRIMITIVE_OBJECT
		redefine
			object, display_object, accepts_child, is_full
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_TREE
		-- The vision2 object that `Current' represents.

	display_object: EV_TREE
		-- The representation of `object' used in `build_window'.

	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := False
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_COMMAND_ADD_OBJECT, GB_PASTE_OBJECT_COMMAND} -- Implementation

	accepts_child (a_type: STRING): BOOLEAN is
			-- Does current accept new objects of
			-- type `a_type'?
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_tree_item_string)) then
				Result := True
			end
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


end -- class GB_TREE_OBJECT
