indexing
	description: "Sets of compactly coded dates";
	date: "$Date$";
	revision: "$Revision$"

class
	DATE_SET

inherit
	ARRAY [INTEGER]
		rename
			make as make_array,
			put as put_array,
			item as item_array
		end

create
	make

feature -- Creation
	
	make (n: INTEGER) is
			-- Create structure for initial
			-- estimate of `n' dates.
		require
			n_not_void: n /= Void
		do
			make_array (1, n)
			last := 0
		end

feature -- Access

	item (i: INTEGER): DATE is
			-- Element at index `i'
		require
			i_not_void: i /= Void
		do
			create Result.make_by_compact_date (item_array(i))
		end

	last: INTEGER
			-- Index of the last element inserted

feature -- Element change

	put (d: DATE) is
			-- Insert `d';
			-- Index will be given by `last'.
		require 
			d_not_void: d /= Void
		do
			last := last + 1
			force (d.compact_date, last)
		ensure
			inserted: item (last).is_equal (d);
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
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
