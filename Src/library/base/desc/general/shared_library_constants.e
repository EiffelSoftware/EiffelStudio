indexing

	description:
		"Constants used by DESC (Dynamic External Shared Call) mechanism"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_LIBRARY_CONSTANTS

feature -- Access

	T_array: INTEGER is 0

	T_boolean: INTEGER is 1

	T_character: INTEGER is 2

	T_double: INTEGER is 3

	T_integer: INTEGER is 4

	T_no_type: INTEGER is 10

	T_pointer: INTEGER is 5

	T_real: INTEGER is 6

	T_reference: INTEGER is 7

	T_short_integer: INTEGER is 8

	T_string: INTEGER is 9

feature -- Status report

	Library_freed: INTEGER is 3

	No_error: INTEGER is 0

	No_library: INTEGER is 1

	No_routine: INTEGER is 2;

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

end -- class SHARED_LIBRARY_CONSTANTS


