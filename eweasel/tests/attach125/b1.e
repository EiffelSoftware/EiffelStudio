expanded class B

create
	default_create,
	make

feature {NONE} -- Creation

	make (t: TEST)
			-- Initialize `y` using `t`.
		do
			y := t
		end

feature -- Access

	x: INTEGER
	y: detachable TEST
	z: INTEGER

end