class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			l_a: A
		do
			create l_a.make
			create l_a.make_with_name ("Eiffel")
		end

end
