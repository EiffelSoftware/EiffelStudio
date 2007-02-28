indexing

	description: "References to special objects, for direct access to arrays and strings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Access

	item alias "[]", infix "@" (i: INTEGER): T assign put is
			-- Entry at index `i', if in index interval
		require
			valid_index: valid_index (i)
		do
			Result := area.item (i)
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < area.count)
		end
		
feature -- Element change

	put (v: T; i: INTEGER) is
			-- Replace `i'-th entry, if in index interval, by `v'.
		require
			valid_index: valid_index (i)
		do
			area.put (v, i)
		ensure
			inserted: item (i) = v
		end

feature {NONE} -- Element change

	set_area (other: like area) is
			-- Make `other' the new `area'
		do
			area := other
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class TO_SPECIAL



