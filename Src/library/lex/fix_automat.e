indexing

	description:
		"General finite-state automata, implemented by arrays";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FIX_AUTOMAT [S->STATE] 

obsolete "Use class FIXED_AUTOMATON instead.  Same features, more consistent name."

inherit
	FIXED_AUTOMATON [S]

creation
	make

end -- class FIX_AUTOMAT
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
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
