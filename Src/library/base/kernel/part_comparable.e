indexing

	description:
		"Objects that may be compared according to a partial order relation";

	copyright: "See notice at end of class";
	names: part_comparable, comparison;
	date: "$Date$";
	revision: "$Revision$"

deferred class
	PART_COMPARABLE

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		deferred
		end;

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		do
			Result := (Current < other) or else equal (Current, other)
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
			Result := other < Current
		end;

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
			Result := (other < Current) or else equal (Current, other)
		end;

end -- class PART_COMPARABLE


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
