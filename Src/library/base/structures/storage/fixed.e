indexing

	description:
		"Finite structures whose item count cannot be changed";

	status: "See notice at end of class";
	names: fixed, storage;
	size: fixed;
	date: "$Date$";
	revision: "$Revision$"

deferred class FIXED [G] inherit

	BOUNDED [G]

feature -- Status report

	resizable: BOOLEAN is false;
			-- May `capacity' be changed? (Answer: no.)

invariant

	not_resizable: not resizable

end -- class FIXED


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
