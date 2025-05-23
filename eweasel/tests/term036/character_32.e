note
	description: "Unicode characters, with comparison operations"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	CHARACTER_32

inherit
	WIDE_CHARACTER_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({WIDE_CHARACTER_REF})

feature -- Conversion

	to_character_8: CHARACTER_8
			-- Convert current to CHARACTER_8
		do
			Result := item.to_character_8
		end

	as_upper, upper: CHARACTER_32
			-- Uppercase value of `item'
			-- Returns `item' if not `is_lower'
		do
			Result := to_character_8.upper
		end

	as_lower, lower: CHARACTER_32
			-- Lowercase value of `item'
			-- Returns `item' if not `is_upper'
		do
			Result := to_character_8.lower
		end

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

end
