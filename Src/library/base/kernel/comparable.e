indexing

	description:
		"Objects that may be compared according to a total order relation";

	status: "See notice at end of class";
	names: comparable, comparison;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE inherit

	PART_COMPARABLE
		redefine
			infix "<", infix "<=",
			infix ">", infix ">="
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		deferred
		ensure then
			smaller: Result implies not (Current >= other)
		end;

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		do
			Result := not (other < Current)
		ensure then
			equals_smaller: Result implies not (Current > other)
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
			Result := other < Current
		ensure then
			larger: Result implies not (Current <= other)
		end;

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
			Result := not (Current < other)
 		ensure then
			equals_larger: Result implies not (Current < other)
		end;

end -- class COMPARABLE


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
