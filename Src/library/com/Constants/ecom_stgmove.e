indexing

	description: "SToraGe MOVE flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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




end -- class EOLE_STGMOVE

