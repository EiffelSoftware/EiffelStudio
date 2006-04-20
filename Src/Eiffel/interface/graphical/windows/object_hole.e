indexing

	description:	
		"Hole for an object."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, icon_symbol, name, 
			stone_type, menu_name, accelerator
		end

create

	make
	
feature -- Properties

	symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := Pixmaps.bm_Object
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Object_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := Pixmaps.bm_Object_icon
		end;

	name: STRING is
		do
			Result := Interface_names.s_Object_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_object
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

    stone_type: INTEGER is
            -- Type of compatible stone.
        do
            Result := Object_type
        end;
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

end -- class OBJECT_HOLE
