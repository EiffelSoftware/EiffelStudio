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
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1996, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
