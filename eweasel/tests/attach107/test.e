class TEST

create
	make,
	make_arg

feature

	make
		do
			create x.make_arg (1)
		end

	make_arg (n: INTEGER)
		require
			n > 0
		do
		end

feature -- Access

	x: TEST

end
