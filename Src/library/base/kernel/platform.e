indexing

	description:
		"Platform-dependent properties. %
        %This class is an ancestor to all developer-written classes.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PLATFORM inherit

	GENERAL

feature -- Access

	Character_bits: INTEGER is 8;

	Integer_bits: INTEGER is 32;

	Real_bits: INTEGER is 32;

	Double_bits: INTEGER is 64;

end -- class PLATFORM


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
