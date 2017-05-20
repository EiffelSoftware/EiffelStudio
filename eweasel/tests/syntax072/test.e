class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: ARRAY [ARRAY [INTEGER]]
		do
			create a.make_filled (create {ARRAY [INTEGER]}.make_filled (3, 1, 5), 1, 7)
			io.put_integer (a [6] [4])
			io.put_new_line
		end

end
