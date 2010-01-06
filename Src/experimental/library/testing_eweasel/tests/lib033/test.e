class
	TEST

create
	make

feature {NONE} -- Initialization
	make
			-- Entry point
		local
			f: RAW_FILE
			i: INTEGER
		do
			create f.make_open_write ("raw_file")
			f.put_integer (47)
			f.put_double (12345678.0)
			f.close

				-- make_open_read is fine, but *write or *append causes the problem
			create f.make_open_read_write ("raw_file")
			create f.make_open_read_write ("raw_file")
			f.read_integer
			i := f.count
			f.read_double
			f.close
		end

end
