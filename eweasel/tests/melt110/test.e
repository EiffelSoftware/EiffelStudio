class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			b: BOOLEAN
			c: CHARACTER_32
		do
			c := 'a'
			b := c.is_character_8
			io.put_boolean (b)
			io.put_new_line
		end

end