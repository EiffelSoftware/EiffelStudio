indexing

	description:
		"References to special objects, for direct access to arrays and strings";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TO_SPECIAL [T] creation

	make_area

feature -- Access

	area: SPECIAL [T];
			-- Special data zone

feature {NONE} -- Initialization

	make_area (n: INTEGER) is
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0;
		do
			-- Built-in
		ensure
			area_allocated: area /= Void and then area.count = n
		end;

feature {NONE} -- Element change

	set_area (other: like area) is
			-- Make `other' the new `area'
		do
			area := other
		end;

end -- class TO_SPECIAL


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
