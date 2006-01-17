indexing

	description: 
		"Stone representating a breakable point."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CALL_STACK_STONE 

inherit

	STONE

create

	make
	
feature {NONE} -- Initialization

	make (level_num: INTEGER) is
			-- Initialize `level_number' to `level_num'.
		require
			level_num: level_num > 0
		do
			level_number := level_num
		end
 
feature -- Access

	level_number: INTEGER;
			-- Level number of call stack

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end;

	stone_type: INTEGER is 
		do 
			Result := Call_stack_type 
		end;
 
	stone_name: STRING is 
		do 
			Result := stone_signature
		end;

	stone_signature: STRING is "";
 
	click_list: ARRAY [CLICK_STONE] is do end;

	origin_text: STRING is 
		do
			Result := stone_signature
		end

	icon_name: STRING is
		do
			Result := stone_signature
		end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
		end

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_call_stack (Current)
		end;

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

end -- class BREAKABLE_STONE
