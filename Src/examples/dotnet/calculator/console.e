class
	CONSOLE

feature

	io: SYSTEM_CONSOLE

	putstring (a: STRING) is
		do
			io.write_system_string (a)
		end

	putreal (r: REAL) is
		do
			io.write_system_single (r)
		end

	putchar (c: CHARACTER) is
		do
			io.write_system_char (c)
		end

	new_line is
		do
			putstring ("%N")
		end

	read_real is
		local
			s: STRING
		do
			s := io.readline
			lastreal := s.tosingle
		end

	readline is
		do
			laststring := io.readline
		end
	
	next_line is
		do
			laststring := io.readline
		end

	laststring: STRING

	lastreal: REAL

end
