note

	description: "Integer values coded on 16 bits"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

expanded class INTEGER_16 inherit

	INTEGER_16_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({INTEGER_16_REF}),
	to_real: {REAL},
	to_double: {DOUBLE},
	to_integer_32: {INTEGER},
	to_integer_64: {INTEGER_64}

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class INTEGER_16



