indexing

	description:
		"Cursors for hash table traversal";

	status: "See notice at end of class";
	names: linked_list_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class HASH_TABLE_CURSOR inherit

	CURSOR

creation

	make

feature {NONE} -- Initialization

	make (pos: INTEGER) is
			-- Create a new cursor.
		do
			position := pos
		ensure
			position_set: position = pos
		end

feature {HASH_TABLE} -- Access

	position: INTEGER
			-- Cursor position

end -- class HASH_TABLE_CURSOR

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

