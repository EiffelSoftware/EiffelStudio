indexing
	description: "[
		References to objects containing reference to object
		meant to be exchanged with non-Eiffel software.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

expanded external class TYPED_POINTER [G]

inherit
	POINTER_REF
		rename
			item as pointer_item,
		export
			{NONE} pointer_item
		end

create {NONE}

convert
	to_pointer: {POINTER}

feature -- Conversion

	to_pointer: POINTER is
			-- Convert to POINTER instance.
		do
			-- Built-in
		end

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

end
