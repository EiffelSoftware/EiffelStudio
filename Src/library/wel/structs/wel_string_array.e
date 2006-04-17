indexing
	description: "Fixed integer array for WEL_STRUCTURE. Used internally by WEL. %
				 % useful to protect integer arrays within an external call"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRING_ARRAY

inherit
	PLATFORM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_array: ARRAY [STRING]) is
			-- Create a fixed string array
			-- from an existing standard string array.
		require
			a_array_not_void: a_array /= Void
		local
			i, j, l_count, l_upper: INTEGER
			l_string: WEL_STRING
		do
			l_count := a_array.count
			count := l_count
			create item.make (l_count * Pointer_bytes)
			create strings.make (1, l_count)
			from
				i := a_array.lower
				l_upper := a_array.upper
			until
				i > l_upper
			loop
				create l_string.make (a_array.item (i))
				strings.put (l_string, j + 1)
				item.put_pointer (l_string.item, j * Pointer_bytes)
				i := i + 1
				j := j + 1
			end
		ensure
			initialized: item /= Void and strings /= Void
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in the array

	item: MANAGED_POINTER
			-- Underlying C array pointer

	strings: ARRAY [WEL_STRING];
			-- Keep references on strings so they don't get collected too early

invariant
	attached_item: item /= Void
	attached_strings: strings /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class WEL_STRING_ARRAY

