deferred class MY_LINEAR[G]

inherit
	LINEAR [G]
		rename
			search as ise_linear_search
		end

feature -- Access

	cursor : MY_LINEAR_CURSOR is
		do
		end

	index: INTEGER is
		deferred
		end

	count: INTEGER is
		deferred
		end

feature -- Status report

	valid_cursor (a_cursor : like cursor) : BOOLEAN is
		deferred
		end

feature -- Cursor movement

	go_to (a_cursor : like cursor) is
		do
		end

end


