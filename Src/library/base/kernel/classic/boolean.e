indexing

	description:
		"Truth values, with the boolean operations"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

expanded class BOOLEAN

inherit
	BOOLEAN_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference BOOLEAN}),
	to_reference: {reference BOOLEAN}

feature {NONE} -- Initialization

	make_from_reference (v: reference BOOLEAN) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
--			item := v.item
		ensure
--			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference BOOLEAN is
			-- Associated reference of Current
		do
			create Result
--			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
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

end -- class BOOLEAN



