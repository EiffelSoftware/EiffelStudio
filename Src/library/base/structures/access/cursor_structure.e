indexing

	description:
		"Active structures, which always have a current position %
		%accessible through a cursor.";

	status: "See notice at end of class";
	names: cursor_structure, access;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CURSOR_STRUCTURE [G] inherit

	ACTIVE [G]

feature -- Access

	cursor: CURSOR is
			-- Current cursor position
		deferred
		end;

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		deferred
		end;

feature -- Cursor movement

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		require
			cursor_position_valid: valid_cursor (p)
		deferred
		end;

end -- class CURSOR_STRUCTURE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

