class TEST

inherit
	ARGUMENTS

create
	make

feature

	make is
		local
			f: PLAIN_TEXT_FILE
			l_list: LIST [STRING]
			l_formatter: FORMAT_DOUBLE
		do
			create l_formatter.make (5, 3)
			create f.make_open_read ("file.txt")

			f.read_line
			io.put_string (f.last_string)
			io.put_new_line

			f.read_line
			io.put_string (f.last_string)
			io.put_new_line

			f.read_line
			l_list := f.last_string.split (' ')
			io.put_integer (l_list.first.to_integer_32)
			io.put_character (' ')
			io.put_integer (l_list.last.to_integer_32)
			io.put_new_line

			f.read_integer
			io.put_integer (f.last_integer)

			f.read_character
			io.put_character (f.last_character)

			f.read_integer
			io.put_integer (f.last_integer)

			f.read_character
			io.put_character (f.last_character)

			f.read_integer
			io.put_integer (f.last_integer)

			f.read_character
			io.put_character (f.last_character)

			f.read_integer
			io.put_integer (f.last_integer)
			io.put_new_line
			f.next_line

			f.read_double
			io.put_string (l_formatter.formatted (f.last_double))

			f.read_character
			io.put_character (f.last_character)

			f.read_double
			io.put_string (l_formatter.formatted (f.last_double))
			io.put_new_line
			f.close
		end

end
