note

	description:
		"Cursors for arrayed lists"

	status: "See notice at end of class"
	names: fixed_list_cursor, cursor;
	date: "$Date$"
	revision: "$Revision$"

class ARRAYED_LIST_CURSOR inherit

	CURSOR

create

	make

feature {ARRAYED_LIST} -- Initialization

	make (current_index: INTEGER)
			-- Create a cursor and set it up on `current_index'.
		do
			index := current_index
		end

feature {ARRAYED_LIST} -- Access

	index: INTEGER;
		-- Index of current item

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

end -- class ARRAYED_LIST_CURSOR



