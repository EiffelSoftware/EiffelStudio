indexing

	description:
		"Circular chains implemented as two-way linked lists";

	status: "See notice at end of class";
	names: two_way_circular, ring, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_CIRCULAR [G] inherit

	LINKED_CIRCULAR [G]
		redefine
			list
		end
creation
	make

feature -- Implementation

	list: TWO_WAY_LIST [G]

end -- class TWO_WAY_CIRCULAR


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
