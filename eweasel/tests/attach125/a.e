expanded class A

create
	default_create,
	make

feature {NONE} -- Creation

	make (t: TEST)
			-- Initialize `y` using `t`.
		do
			create y.make (t)
		end

feature -- Access

	x: INTEGER
	y: B
	z: INTEGER

end