indexing

	description: "References to special objects, for direct access to arrays and strings"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TO_SPECIAL [T]

create
	make_area

feature -- Access

	area: SPECIAL [T]
			-- Special data zone

feature {NONE} -- Initialization

	make_area (n: INTEGER) is
			-- Creates a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		do
			create area.make (n)
		ensure
			area_allocated: area /= Void and then area.count = n
		end

feature {NONE} -- Element change

	set_area (other: like area) is
			-- Make `other' the new `area'
		do
			area := other
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

end -- class TO_SPECIAL



