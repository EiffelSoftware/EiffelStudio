indexing

	description: "SToraGe MOVE flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_STGMOVE

feature -- Access

	Stgmove_move: INTEGER is
			-- Carry out the move operation, as expected.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGMOVE_MOVE"
		end

	Stgmove_copy: INTEGER is
			-- Carry out the first part of the move operation but do
			-- not remove the original element.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGMOVE_COPY"
		end

	is_valid_stgmove (stgmove: INTEGER): BOOLEAN is
			-- Is `stgmove' a valid storage move flag?
		do
			Result := stgmove = Stgmove_move or
						stgmove = Stgmove_copy
		end
		
end -- class EOLE_STGMOVE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
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

