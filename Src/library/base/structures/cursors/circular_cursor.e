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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

