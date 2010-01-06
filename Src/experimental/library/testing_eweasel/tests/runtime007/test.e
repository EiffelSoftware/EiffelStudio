class TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			c := 'c'
			st := "c"
			c := new_character (19)
			st := new_string (19)
			io.put_character (c)
			io.put_new_line
			io.put_string (st)
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

	new_string (i: INTEGER): STRING is
		local
			mem: MEMORY
		do
			create mem
			mem.collect
			Result := "C"
		end

	c: CHARACTER
	st: STRING

end
