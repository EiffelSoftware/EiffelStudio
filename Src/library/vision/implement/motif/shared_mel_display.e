indexing

	description: 
		"Save the last open display.";
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
			!! Result.put (Void)
		end;

end -- class SHARED_MEL_DISPLAY
