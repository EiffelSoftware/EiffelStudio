indexing

	description:
		"Cursors for circular lists";

	status: "See notice at end of class";
	names: circular_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class CIRCULAR_CURSOR

 inherit
	CURSOR

creation

	make

feature {LINKED_LIST} -- Initialization

	make (curs: like cursor; int: BOOLEAN; start : INTEGER) is
			-- Create a cursor and set it up on `active_element'.
		do
			cursor := curs
			internal_exhausted := int
			starter := start
		end;

feature {CIRCULAR} -- Implementation

	cursor: CURSOR;
			-- Current element in implementation

	internal_exhausted : BOOLEAN;
			-- Has traversal passsed the start?

	starter : INTEGER
			-- Index of start position

end -- class CIRCULAR_CURSOR


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

