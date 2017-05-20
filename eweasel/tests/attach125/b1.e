expanded class B

create
	default_create,
	make

feature {NONE} -- Creation

	make (t: TEST)
			-- Initialize `y` using `t`.
		do
			q := t
		end

feature -- Access

	p: INTEGER
	q: detachable TEST
	r: INTEGER

end