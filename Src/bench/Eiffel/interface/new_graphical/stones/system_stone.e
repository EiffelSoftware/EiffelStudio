indexing
	description: "Stone representing a system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	SYSTEM_STONE 

inherit
	SHARED_EIFFEL_PROJECT

	FILED_STONE

feature -- Access

	file_name: STRING is
			-- Name of the lace file
		do
			Result := Eiffel_ace.file_name
		end
 
	click_list: CLICK_STONE_ARRAY is
		do
			create Result.make (Eiffel_ace.click_list, Void)
		end
 
	stone_signature: STRING is
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				Result := Eiffel_system.name
			else
				-- FIXME: `stone_signature' is asked only when system 
				-- is compiled, and therefore `system_name' exists.
				Result := "Uncompiled"
			end
		end

	icon_name: STRING is "Ace"

	header: STRING is "Ace"
 
	stone_type: INTEGER is 
		do 
			Result := System_type 
		end

--	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
--		do
--			Result := Cursors.cur_System
--		end
 
--	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
--		do
--			Result := Cursors.cur_X_system
--		end
 
	stone_name: STRING is 
		do 
			Result := Interface_names.s_System 
		end
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := Eiffel_ace.click_list /= Void
		end

feature -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name' of lace.
		do
			Eiffel_ace.set_file_name (s)
		end
 
feature -- Update

--	process (hole: HOLE) is
--			-- Process Current stone dropped in hole `hole'.
--		do
--			hole.process_system (Current)
--		end

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

end -- class SYSTEM_STONE
