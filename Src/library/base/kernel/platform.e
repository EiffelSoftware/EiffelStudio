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
			"C | %"eif_misc.h%""
		alias
			"eschar_size"
		end;

	Integer_bits: INTEGER is
			-- Number of bits in a value of type `INTEGER'
		external
			"C | %"eif_misc.h%""
		alias
			"esint_size"
		end;

	Real_bits: INTEGER is
			-- Number of bits in a value of type `REAL'
		external
			"C | %"eif_misc.h%""
		alias
			"esreal_size"
		end;

	Double_bits: INTEGER is
			-- Number of bits in a value of type `DOUBLE'
		external
			"C | %"eif_misc.h%""
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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

