class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			a: A
			b: B
			c: C
			d: D
		do
			create a
			create b
			create c
			create d
		end

end
