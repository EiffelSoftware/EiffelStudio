indexing

	description: 
		"Shared instance of the last callback structure processed.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_CALLBACK_STRUCT

feature -- Access

	last_callback_struct: MEL_CALLBACK_STRUCT is
		do	
			Result := last_callback_struct_cell.item;
		end;

feature {NONE} -- Implementation

	last_callback_struct_cell: CELL [MEL_CALLBACK_STRUCT] is
		once
		 	!! Result.put (Void)
		end;

	set_last_callback_struct (an_struct: like last_callback_struct) is
		do
			last_callback_struct_cell.put (an_struct)
		end;

end -- class SHARED_CALLBACK_STRUCT


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

