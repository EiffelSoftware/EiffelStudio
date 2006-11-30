class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			i: INTEGER
		do
			create test_array.make (0, 1000)
			from
				i := 1000000
			until
				i = 0
			loop
				play
				i := i - 1
			end
		end

feature

	test_array: ARRAY [B]

	f: A
	
	play is
		local
			f1,f2: A
		do
			f := f1
			f := f2
		end

end
