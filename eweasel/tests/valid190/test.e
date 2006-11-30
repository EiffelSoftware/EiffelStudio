indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			c1, c2, c3, c4: CHARACTER_8
			c32: CHARACTER_32
		do
			io.put_string ("CHARACTER_8 tests%N")
			c1 := '%/0x65/'
			io.put_character (c1)
			io.put_new_line
			c2 := '%/101/'
			io.put_character (c2)
			io.put_new_line
			c3 := '%/0b01100101/'
			io.put_character (c3)
			io.put_new_line
			c4 := '%/0c145/'
			io.put_character (c4)
			io.put_new_line
			io.put_boolean (c1 = c2 and c2 = c3 and c3 = c4)
			io.put_new_line
			io.put_string ("CHARACTER_32 tests%N")
			c32 := '%/0x12345678/'
			io.put_string (c32.out)
			io.put_new_line
			c32 := '%/0b100000000/'
			io.put_string (c32.out)
			io.put_new_line
			c32 := '%/0c777/'
			io.put_string (c32.out)
			io.put_new_line
		end

end
