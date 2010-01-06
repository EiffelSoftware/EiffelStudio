class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			if attached {STRING} f as l_f then
				io.put_string (l_f)
				io.put_new_line
			end
		end

feature -- Access

	counter: INTEGER

	f: ANY
		do
			Result := "STRING"
			counter := counter + 1
			print (counter.out + "%N")
		end

end
