indexing
	Warning: "[
		If you are precompiling a subset of EiffelBase, it is 
		preferable NOT to remove this class from the subset. 
		If you remove it you may see unnecessary recompilations
		after changes.
		]"
	description: "[
		Class used to ensure proper precompilation of EiffelBase. 
		Not to be used otherwise.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	DECLARATOR

feature {NONE} -- Implementation

	s1: SPECIAL [INTEGER]

	s1_2: SPECIAL [INTEGER_8]

	s1_3: SPECIAL [INTEGER_16]

	s1_4: SPECIAL [INTEGER_64]

	s2: SPECIAL [REAL]

	s3: SPECIAL [DOUBLE]

	s4: SPECIAL [BOOLEAN]

	s5: SPECIAL [CHARACTER]

	s6: SPECIAL [POINTER]

	s7: SPECIAL [ANY]

	s8: SPECIAL [NATURAL_8]

	s8_2: SPECIAL [NATURAL_16]

	s8_3: SPECIAL [NATURAL_32]

	s8_4: SPECIAL [NATURAL_64];

indexing
	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DECLARATOR
