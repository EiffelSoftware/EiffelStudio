note
	description: "[
		{PEG_LONGEST_MATCH}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_LONGEST_MATCH

create
	make

feature -- Initialization

	make
		do
			count := 1
		end

feature -- Access

	update_length (a_length: INTEGER)
			-- Updates the count if `a_length' is bigger than a_length
		require
			a_length_bigger_than_zero: a_length > 0
		do
			if a_length > count then
				count := a_length
			end
		end

	count: INTEGER
			-- Furthest count

	reset
			-- Resets the counter to 1
		do
			count := 1
		ensure
			count_reset: count = 1
		end

invariant
	count_bigger_than_zero: count > 0

end
