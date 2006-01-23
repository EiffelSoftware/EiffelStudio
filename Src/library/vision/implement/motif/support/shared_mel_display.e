indexing

	description: 
		"Save the last open display."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_MEL_DISPLAY

feature {NONE} -- Access

	last_open_display: MEL_DISPLAY is
			-- Last open display
		do
			Result := display_cell.item
		end;

	display_cell: CELL [MEL_DISPLAY] is
		once
			create Result.put (Void)
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SHARED_MEL_DISPLAY

