indexing

	description:
		"Linkable cells containing a reference to their right neighbor";

	status: "See notice at end of class";
	names: linkable, cell;
	representation: linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKABLE [G] inherit

	CELL [G]
		export
			{CELL, CHAIN}
				put;
			{ANY}
				item
		end

feature -- Access

	right: like Current;
			-- Right neighbor

feature {CELL, CHAIN} -- Implementation

	put_right (other: like Current) is
			-- Put `other' to the right of current cell.
		do
			right := other
		ensure
			chained: right = other
		end;

	forget_right is
			-- Remove right link.
		do
			right := Void
		ensure
			not_chained: right = Void
		end;

end -- class LINKABLE


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
