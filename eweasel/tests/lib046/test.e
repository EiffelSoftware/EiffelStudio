class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			c: CHARACTER_32
		do
				-- Look at the first character of the command line.
			c := (create {ARGUMENTS_32}).command_line [1]
				-- It should not be a space.
			io.put_string ("Space: ")
			io.put_boolean (c.is_space)
			io.put_new_line
				-- It should not be a control character.
			io.put_string ("Control: ")
			io.put_boolean (c.is_control)
			io.put_new_line
		end
end