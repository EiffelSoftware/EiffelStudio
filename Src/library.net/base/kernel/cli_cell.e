indexing
	description:
		"Enables Eiffel generic classes to hold references on SYSTEM_OBJECT classes"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CLI_CELL [G -> SYSTEM_OBJECT]

inherit
	ANY
		redefine
			is_equal
		end

create
	put

feature -- Access

	item: G
			-- Content of cell.

feature -- Element change

	put, replace (v: like item) is
			-- Make `v' the cell's `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_item, l_other: G
		do
			l_item := item
			l_other := other.item
			Result := l_item = l_other
			if not Result then
				Result := l_item /= Void and then l_item.equals (l_other) 
			end
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

end -- class CLI_CELL
