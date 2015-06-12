note
	description: "A random number generator that automatically initializes with the current time as a seed."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SIMPLE_RANDOM

inherit
	RANDOM

create
	make_time

feature {NONE} -- Initialization

	make_time
			-- Initialize `Current' with the current time in milliseconds.
		local
			time: C_DATE
			l_seed: INTEGER
		do
			create time.make_utc
			l_seed := time.hour_now
			l_seed := l_seed * 60  + time.minute_now
			l_seed := l_seed * 60 + time.second_now
			l_seed := l_seed * 1000 + time.millisecond_now

			set_seed (l_seed)
			start
		end

feature -- Factory functions

	new_double: DOUBLE
			-- Return a new random double item between 0 and 1.
		do
			Result := double_item
			forth
		end

	new_integer: INTEGER
			-- Return a new integer item.
		do
			Result := item
			forth
		end

end
