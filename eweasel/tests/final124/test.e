class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			f
		end

feature {NONE} -- Access

	t: STRING
		attribute
			Result := "test"
		end

	f
		do
			io.put_string (t)
			io.put_new_line
		end

end
