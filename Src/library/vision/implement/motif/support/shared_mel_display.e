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
			create Result.put (Void)
		end;

end -- class SHARED_MEL_DISPLAY

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

