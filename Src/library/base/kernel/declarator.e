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
