indexing

	WARNING:
	"If you are precompiling a subset of EiffelBase, it is %
	%preferable NOT to remove this class from the subset. %
	%If you remove it you may see EiffelBench perform %
	%apparently unnecessary recompilations after changes."

	description:
		"Class used to ensure proper precompilation of EiffelBase. %
		%Not to be used otherwise.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	DECLARATOR

feature {NONE} -- Implementation

	s1: ARRAY [INTEGER];

	s2: ARRAY [REAL];

	s3: ARRAY [DOUBLE];

	s4: ARRAY [BOOLEAN];

	s5: ARRAY [CHARACTER];

	s6: ARRAY [POINTER];

	s7: ARRAY [ANY];

end


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

