indexing

	description:
		"Cells containing an item";

	status: "See notice at end of class";
	names: cell;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class CELL [G]

creation
	put

feature -- Access

	item: G
			-- Content of cell.

feature -- Element change

	put, replace (v : like item) is
			-- Make `v' the cell's `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end

end -- class CELL


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

