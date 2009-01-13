class
	TEST

create
	make

feature {NONE} -- Creation

	make
		do
			create s.make_empty
		end

feature -- Access

	s: STRING

	a: TEST
		attribute
			create Result.make (Current)
		end

end
