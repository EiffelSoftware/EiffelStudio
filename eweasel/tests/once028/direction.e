once class DIRECTION

create
	down,
	left,
	right,
	up

feature {NONE} -- Creation

	down once y_scroll := 3 end
	left once x_scroll := -1 end
	right once x_scroll := 1 end
	up once y_scroll := -3 end

feature -- Access

	x_scroll: INTEGER assign set_x_scroll
			-- The number of columns to scroll when current direction is used.
			-- Positive value is used for scrolling right, negative for scrolling left.

	y_scroll: INTEGER
			-- The number of lines to scroll when current direction is used.
			-- Positive value is used for scrolling down, negative for scrolling up.

	set_x_scroll (new_x_scroll: like x_scroll)
			-- Set `x_scroll` to the given value.
		require
			same_direction: x_scroll.sign = new_x_scroll.sign
		do
			x_scroll := new_x_scroll
		ensure
			x_scroll_set: x_scroll = new_x_scroll
		end

end