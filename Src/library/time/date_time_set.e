indexing
	description: "Sets of compactly coded date-time pairs";
	date: "$Date$";
	revision: "$Revision$"

class
	DATE_TIME_SET

create
	make

feature -- Creation

	make (n: INTEGER) is
			-- Create structure for initial
			-- estimate of `n' date-time pairs.
		require
			n_not_void: n /= Void
		do
			create date_set.make (n)
			create time_set.make (n)
			last := 0
		end

feature -- Access

	item (i: INTEGER): DATE_TIME is
			-- Element at index `i'
		require
			i_not_void: i /= Void
		do
			create Result.make_by_date_time (date_set.item (i), time_set.item (i))
		end

	last: INTEGER
			-- Index of the last element inserted

feature -- Element change

	put (dt: DATE_TIME) is
			-- Insert `dt';
			-- Index will be given by `last'.
		require 
			dt_not_void: dt /= Void
		do
			last := last + 1
			date_set.put (dt.date)
			time_set.put (dt.time)
		ensure
			inserted_date: date_set.item (last).is_equal (dt.date);
			inserted_time: time_set.item (last).is_equal (dt.time);
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

