indexing

	description: "SToraGe MOVE flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_STGMOVE

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

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
