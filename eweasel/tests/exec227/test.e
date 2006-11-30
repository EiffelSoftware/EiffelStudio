class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.

		local
			t: TEST1 [INTEGER]
			i: INTEGER
			obj: ANY
		do
			create t
			obj := 5
			i := t.attempt (obj)
			i := t.attempt (5)
		end

end
