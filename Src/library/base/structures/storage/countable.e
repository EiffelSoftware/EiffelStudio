indexing

	description:
		"Infinite containers whose items are in one-to-one %
		%correspondence with the integers.";

	status: "See notice at end of class";
	names: countable, infinite, storage ;
	date: "$Date$";
	revision: "$Revision$"

deferred class COUNTABLE [G] inherit

	INFINITE [G]

feature -- Access

	item (i: INTEGER): G is
			-- The `i'-th item
		require
			positive_argument: i > 0
		deferred
		end;

end -- class COUNTABLE


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
