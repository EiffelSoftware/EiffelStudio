indexing
	description: "Sets of compactly coded date-time pairs"
	date: "$Date$"
	revision: "$Revision$"

class
	DATE_TIME_SET

create

	make

feature -- Initalization

	make (n: INTEGER) is
			-- Create set for `n' date-time pairs.
		require
			positive: n > 0
		do
			create date_set.make (n)
			create time_set.make (n)
			last := 0
		end

feature -- Access

	item (i: INTEGER): DATE_TIME is
			-- Item at index `i'
		require
			index_in_range: 1 <= i and i <= last
		do
			create Result.make_by_date_time (date_set.item (i), 
				time_set.item (i))
		end

	last: INTEGER
			-- Index of the last item inserted

feature -- Element change

	put (dt: DATE_TIME) is
			-- insert `dt' as last item.
		require 
			exists: dt /= Void
		do
			last := last + 1
			date_set.put (dt.date)
			time_set.put (dt.time)
		ensure
			inserted_date: equal (date_set.item (last), dt.date)
			inserted_time: equal (time_set.item (last), dt.time)
		end

feature {NONE} -- Implementation

	date_set: DATE_SET

	time_set: TIME_SET

invariant

	last_non_negative: last >= 0
	last1: last = date_set.last
	last2: last = time_set.last

end -- class DATE_TIME_SET

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

