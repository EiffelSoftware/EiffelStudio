class
	TEST

create
	make

feature {NONE} -- Initialization
	make
			-- Entry point
		local
			f1, f2: RAW_FILE
		do
			create f1.make_open_write ("test.txt")
			f1.put_string ("S")
			f1.flush
			create f2.make_open_read ("test.txt")
			f2.read_stream (10)
			f2.close
			f1.close
			if f2.last_string /~ "S" then
				io.put_string ("Not OK!%N")
			end
		end

end
