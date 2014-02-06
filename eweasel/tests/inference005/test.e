class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			i
			s
		do
			i := 5
			create i
			s := "Test"
			create s.make_from_string ("Test")
		end

end
