note
	description: "An INTEGER_INTERVAL with a smarter initialization."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_INTEGER_INTERVAL

inherit

	INTEGER_INTERVAL
		redefine
			subinterval
		end

create
	make_new

feature {NONE} -- Initialization

	make_new (min_index, max_index: INTEGER)
			-- Set up interval to have bounds `min_index' and
			-- `max_index' (empty if `min_index' > `max_index')
		require
			valid_bounds: min_index <= max_index + 1
		do
			lower := min_index
			upper := max_index
		ensure
			lower_defined: lower_defined
			upper_defined: upper_defined
			set:(lower = min_index) and (upper = max_index)
			empty_if_not_in_order:
				(min_index > max_index) implies is_empty
		end

feature -- Duplication

	subinterval (start_pos, end_pos: INTEGER): like Current
			-- Interval made of items of current array within
			-- bounds `start_pos' and `end_pos'.
		do
			create Result.make_new (start_pos, end_pos)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
