note
	description: "Sets of compactly coded times"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
	make (n: INTEGER)
			-- Create set for `n' times.
		require
			positive: n > 0
		do
			make_array (1, 2 * n)
			last := 0
		end

feature -- Access

	item (i: INTEGER): TIME
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

	put (t: TIME)
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

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TIME_SET


