indexing

	description:
		"Platform-dependent properties. %
		%This class is an ancestor to all developer-written classes.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PLATFORM inherit

	GENERAL

feature -- Access

	Character_bits: INTEGER is
			-- Number of bits in a value of type `CHARACTER'
		external
			"C | <misc.h>"
		alias
			"eschar_size"
		end;

	Integer_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER'
		external
			"C | <misc.h>"
		alias
			"esint_size"
		end;

	Real_bits: INTEGER is
			-- Number of bits in a value of type `REAL'
		external
			"C | <misc.h>"
		alias
			"esreal_size"
		end;

	Double_bits: INTEGER is
			-- Number of bits in a value of type `DOUBLE'
		external
			"C | <misc.h>"
		alias
			"esdouble_size"
		end;

	Operating_environment: OPERATING_ENVIRONMENT is
			-- Objects available from the operating system
		once
			!!Result
		end;

end -- class PLATFORM


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
