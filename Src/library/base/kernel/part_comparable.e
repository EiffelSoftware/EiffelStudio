indexing

	description:
		"Objects that may be compared according to a partial order relation";

	status: "See notice at end of class";
	names: part_comparable, comparison;
	date: "$Date$";
	revision: "$Revision$"

deferred class
	PART_COMPARABLE

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		require
			other_exists: other /= Void
		deferred
		end;

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		require
			other_exists: other /= Void
		do
			Result := (Current < other) or is_equal (other)
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		require
			other_exists: other /= Void
		do
			Result := other < Current
		end;

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		require
			other_exists: other /= Void
		do
			Result := (other < Current) or is_equal (other)
		end;

end -- class PART_COMPARABLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
