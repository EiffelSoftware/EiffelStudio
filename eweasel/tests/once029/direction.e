once class DIRECTION

create
	down,
	left,
	right,
	up

feature {NONE} -- Creation

	down once $ONCE_KEY y_scroll := 3 end
	left once $ONCE_KEY x_scroll := -1 end
	right once $ONCE_KEY x_scroll := 1 end
	up once $ONCE_KEY y_scroll := -3 end

feature -- Access

	x_scroll: INTEGER
			-- The number of columns to scroll when current direction is used.
			-- Positive value is used for scrolling right, negative for scrolling left.

	y_scroll: INTEGER
			-- The number of lines to scroll when current direction is used.
			-- Positive value is used for scrolling down, negative for scrolling up.

end