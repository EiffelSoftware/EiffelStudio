class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			io.put_string (f.generating_type)
			io.put_new_line
		end

feature {NONE} -- Tests
	 
	f: A [like Current] is
		do
			create Result
		end

end
