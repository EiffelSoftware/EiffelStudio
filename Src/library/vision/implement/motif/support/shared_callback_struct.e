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
		 	create Result.put (Void)
		end;

	set_last_callback_struct (an_struct: like last_callback_struct) is
		do
			last_callback_struct_cell.put (an_struct)
		end;

end -- class SHARED_CALLBACK_STRUCT

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

