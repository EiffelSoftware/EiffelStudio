class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Run test.
		local
			b: SPECIAL [CHARACTER_8]
			s: STREAM
		do
			create b.make_filled ('A', 8_000_000)
			create s.make
			s.independent_store (b)
		end

end
