indexing

	description:
		"Cells containing an item";

	status: "See notice at end of class";
	names: cell;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class CELL [G] creation

	put

feature -- Access

	item: G;
			-- Content of cell.

feature -- Element change
	put, replace (v : like item) is
			-- Make `v' the cell's `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end;

end -- class CELL


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
