class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			create {TEST3} t
			t.put1 (End_of_buffer_character, 2)
			t.put2 (End_of_buffer_character, 2)
		end

	t: TEST2

	End_of_buffer_character: CHARACTER is '%U'

end
