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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

