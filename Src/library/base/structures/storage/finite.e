indexing

	description:
		"Structures with a finite item count";

	copyright: "See notice at end of class";
	names: finite, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class FINITE [G] inherit

	BOX [G]

feature -- Measurement

	count: INTEGER is
			-- Number of elements
		deferred
		end;

feature -- Status report

	empty: BOOLEAN is
			-- Is structure empty ?
		do
			Result := (count = 0)
		end;

invariant

	empty_definition: empty = (count = 0);
	non_negative_count: count >= 0

end -- class FINITE


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
