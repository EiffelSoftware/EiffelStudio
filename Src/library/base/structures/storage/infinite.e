indexing

	description:
		"Infinite containers.";

	copyright: "See notice at end of class";
	names: infinite, storage ;
	date: "$Date$";
	revision: "$Revision$"

deferred class INFINITE [G] inherit

	BOX [G]
		redefine
			empty
		end

feature -- Status report

	empty: BOOLEAN is false;
			-- Is structure empty? (Answer: no.)

	full: BOOLEAN is true;
			-- The structure is complete

invariant

	never_empty: not empty;
	always_full: full

end -- class INFINITE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
