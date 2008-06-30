class TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			s := 'c'
			s := new_character (19)
			io.put_character (s)
			io.put_new_line
		end

	new_character (i: INTEGER): CHARACTER is
		local
			mem: MEMORY
		do
			create mem
			mem.collect
			Result := 'C'
		end

	s: CHARACTER

end
