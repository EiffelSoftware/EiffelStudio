indexing
	description: "Sets of compactly coded dates"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DATE_SET inherit

	ARRAY [INTEGER]
		rename
			make as make_array,
			put as put_array,
			item as item_array
		end

create

	make

feature -- Initialization
	
	make (n: INTEGER) is
			-- Create set for `n' dates.
		require
			positive: n > 0
		do
			make_array (1, n)
			last := 0
		end

feature -- Access

	item (i: INTEGER): DATE is
			-- Item at index `i'
		require
			index_in_range: 1 <= i and i <= last
		do
			create Result.make_by_ordered_compact_date (item_array (i))
		end

	last: INTEGER
			-- Index of the last item inserted

feature -- Element change

	put (d: DATE) is
			-- insert `d' as last item.
		require 
			exists: d /= Void
		do
			last := last + 1
			force (d.ordered_compact_date, last)
		ensure
			inserted: equal (item (last), d)
		end
		
invariant
	
	last_non_negative: last >= 0
	last_small_enough: last <= count

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




end -- class DATE_SET


