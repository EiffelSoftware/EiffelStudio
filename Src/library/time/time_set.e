indexing
	description: "Sets of compactly coded times"
	date: "$Date$"
	revision: "$Revision$"

class TIME_SET inherit

	ARRAY [NUMERIC]
		rename
			make as make_array,
			put as put_array,
			item as item_array
		end

create

	make

feature -- Initialization
	
	make (n: INTEGER) is
			-- Create set for `n' times.
		require
			positive: n > 0
		do
			make_array (1, 2 * n)
			last := 0
		end

feature -- Access

	item (i: INTEGER): TIME is
			-- Item at index `i'
		require
			index_in_range: 1 <= i and i <= last
		local
			c_t: INTEGER_REF
			frac_sec: DOUBLE_REF
		do
			c_t ?= item_array ((2 * i) - 1)
			frac_sec ?= item_array (2 * i)
			check
				time_exists: c_t /= Void
				fractional_second_exists: frac_sec /= Void
					-- Because the fractional second value always follows the
					-- compact time value
			end
			create Result.make_by_compact_time (c_t.item)
			Result.set_fractionals (frac_sec.item)
		end

	last: INTEGER
			-- Index of the last item inserted

feature -- Element change

	put (t: TIME) is
			-- insert `t' as last item.
		require 
			exists: t /= Void
		local
			i: INTEGER
		do
			last := last + 1
			i := 2 * last
			force (t.compact_time, i - 1)
			force (t.fractional_second, i)
		ensure
			inserted: equal (item (last), t)
		end

invariant

	last_non_negative: last >= 0
	last_small_enough: last <= count

end -- class TIME_SET


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

