indexing
	description: "Sets of compactly coded dates"
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
			create Result.make_by_compact_date (item_array (i))
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
			force (d.compact_date, last)
		ensure
			inserted: equal (item (last), d)
		end
		
invariant
	
	last_non_negative: last >= 0
	last_small_enough: last <= count

end -- class DATE_SET


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

