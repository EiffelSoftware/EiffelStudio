indexing

	description: "[
		Constants used by memory management.
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	MEM_CONST

feature -- Access

	Total_memory: INTEGER is 0
			-- Code for all the memory managed
			-- by the garbage collector

	Eiffel_memory: INTEGER is 1
			-- Code for the Eiffel memory managed
			-- by the garbage collector

	C_memory: INTEGER is 2
			-- Code for the C memory managed
			-- by the garbage collector

	Full_collector: INTEGER is 0
			-- Statistics for full collections

	Incremental_collector: INTEGER is 1;
			-- Statistics for incremental collections

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

end -- class MEM_CONST



