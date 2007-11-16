class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			f: C
			t: C
		do
			create f.make (False)
			create t.make (True)
			io.put_boolean (f $(OPERATOR) f)
			io.put_new_line
			io.put_boolean (f $(OPERATOR) t)
			io.put_new_line
			io.put_boolean (t $(OPERATOR) f)
			io.put_new_line
			io.put_boolean (t $(OPERATOR) t)
			io.put_new_line
		end

end